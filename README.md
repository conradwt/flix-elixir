# Flix

The purpose of this project is to develop an application that allows fans to comment on and rate movies.

## Getting Started

## Software requirements

- Elixir 1.14.3 or newer

- Erlang 25.2.1 or newer

- Node >= 14.19.0 and <= 15.0

- Phoenix 1.6.15 or newer

- PostgreSQL 14.7 or newer

- Python >= 2.7 and < 3.0

Note: This tutorial was updated on macOS 12.6.2.

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/phoenix). (Tag 'phoenix')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/phoenix).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Quick Installation

1.  clone this repository

    ```bash
    git clone git@github.com:conradwt/flix-elixir.git
    ```

2.  change directory location

    ```bash
    cd flix-elixir
    ```

3.  install dependencies

    ```bash
    mix do deps.get, deps.compile
    ```

4.  create, migrate, and seed the database

    ```bash
    mix ecto:setup
    ```

5.  start the server

    ```bash
    mix phx.server
    ```

6.  navigate to our application within the browser

    ```bash
    open http://localhost:4000
    ```

## Production Setup

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Phoenix References

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## Support

Bug reports and feature requests can be filed with the rest for the Phoenix project here:

- [File Bug Reports and Features](https://github.com/conradwt/flix-elixir/issues)

## License

Flix is released under the [MIT license](./LICENSE.md).

## Copyright

copyright:: (c) Copyright 2021 - 2023 Conrad Taylor. All Rights Reserved.
