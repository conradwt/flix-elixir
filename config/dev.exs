import Config

# Configure your database
config :flix, Flix.Repo,
  username: "postgres",
  password: "postgres",
  database: "flix_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to recompile .js and .css sources.
config :flix, FlixWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "tCI4Bo4USd+jHzx1Wj3qeOT4/rhp60jxq/QJqsod9pf4aI/lHaaNAMkgX/9dwM4d",
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    esbuild: {
      Esbuild,
      :install_and_run,
      [:default, ~w(--sourcemap=inline --watch)]},
    # Start the sass watcher by calling DartSass.install_and_run(:default, args)
    sass: {
      DartSass,
      :install_and_run,
      [:default, ~w(--embed-source-map --source-map-urls=absolute --watch)]
    }
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :flix, FlixWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/flix_web/(live|views)/.*(ex)$",
      ~r"lib/flix_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Set configuration for image upload.
config :waffle,
  storage: Waffle.Storage.Local,
  asset_host: "http://localhost:4000"

# Set configuation for sending e-mail.
config :flix, Flix.Mailer,
  adapter: Bamboo.LocalAdapter,
  open_email_in_browser_url: "http://localhost:4000/sent_emails"
