##
## Base
##

FROM elixir:1.12.2-alpine as base

# labels from https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.authors=conradwt@gmail.com
LABEL org.opencontainers.image.created=$CREATED_DATE
LABEL org.opencontainers.image.revision=$SOURCE_COMMIT
LABEL org.opencontainers.image.title="Zero To GraphQL Using Phoenix"
LABEL org.opencontainers.image.url=https://hub.docker.com/u/conradwt/zero-phoenix
LABEL org.opencontainers.image.source=https://github.com/conradwt/zero-to-graphql-using-phoenix
LABEL org.opencontainers.image.licenses=MIT
LABEL com.conradtaylor.elixir_version=$ELIXIR_VERSION

# set this with shell variables at build-time.
# If they aren't set, then not-set will be default.
ARG CREATED_DATE=not-set
ARG SOURCE_COMMIT=not-set

# environment variables
ENV APP_PATH /app
ENV TMP_PATH /tmp/
ENV PORT 4000

# copy entrypoint scripts and grant execution permissions
# COPY ./dev-docker-entrypoint.sh /usr/local/bin/dev-entrypoint.sh
# COPY ./test-docker-entrypoint.sh /usr/local/bin/test-entrypoint.sh
# RUN chmod +x /usr/local/bin/dev-entrypoint.sh && chmod +x /usr/local/bin/test-entrypoint.sh

#
# https://pkgs.alpinelinux.org/packages?name=&branch=v3.14
#

# install build and runtime dependencies
RUN apk -U add --no-cache \
  build-base=0.5-r2 \
  bzip2=1.0.8-r1 \
  ca-certificates=20191127-r5 \
  curl=7.78.0-r0 \
  fontconfig=2.13.1-r4 \
  git=2.32.0-r0 \
  npm=7.17.0-r0 \
  postgresql-dev=13.4-r0 \
  python3=3.9.5-r1 \
  tini=0.19.0-r0 \
  tzdata=2021a-r0 && \
  rm -rf /var/cache/apk/* && \
  mkdir -p $APP_PATH

ENV MIX_ENV=prod

EXPOSE ${PHOENIX_PORT}
ENV PORT ${PHOENIX_PORT}

WORKDIR ${APP_PATH}

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN npm run --prefix ./assets deploy
RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

ENTRYPOINT ["/sbin/tini", "--"]

# Why should this go into `base` instead of `prod` stage?
# CMD ["mix", "phx.server", "-b", "0.0.0.0"]

##
## Development
##

FROM base as dev

ENV MIX_ENV=dev

# install mix dependencies
RUN mix do deps.get --only ${MIX_ENV}, deps.compile

# build assets
# COPY assets/package.json assets/package-lock.json ./assets/
RUN npm install --prefix ./assets

COPY priv priv
COPY assets assets

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
# RUN mix do compile, release
RUN mix do compile

ENV USER=darnoc
ENV UID=1000
ENV GID=1000

# creates an unprivileged user to be used exclusively to run the Phoenix app
RUN \
  addgroup \
   -g "${GID}" \
   -S "${USER}" \
  && adduser \
   -s /bin/sh \
   -u "${UID}" \
   -G "${USER}" \
   -h "/home/${USER}" \
   -D "${USER}" \
  && su "${USER}"

USER ${USER}:${USER}

CMD ["mix", "phx.server"]

##
## Test
##

FROM dev as test

COPY . .

USER ${USER}:${USER}

RUN mix test

##
## Pre-Production
##

# FROM test as pre-prod

# USER root

# RUN rm -rf ./test

##
## Production
##

FROM alpine:3.14.2 as prod

#
# https://pkgs.alpinelinux.org/packages?name=&branch=v3.14
#

RUN apk add --no-cache \
  openssl=1.1.1l-r0 \
  ncurses-libs=6.2_p20210612-r0

WORKDIR /app

ENV USER=darnoc
ENV UID=1000
ENV GID=1000

# creates an unprivileged user to be used exclusively to run the Phoenix app
RUN \
  addgroup \
   -g "${GID}" \
   -S "${USER}" \
  && adduser \
   -s /bin/sh \
   -u "${UID}" \
   -G "${USER}" \
   -h "/home/${USER}" \
   -D "${USER}" \
  && su "${USER}"

RUN chown ${USER}:${USER} /app

USER ${USER}:${USER}

COPY --from=base --chown=${USER}:${USER} /app/_build/prod/rel/flix ./

ENV HOME=/app

CMD ["bin/flix", "start"]
