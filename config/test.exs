import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :flix, Flix.Repo,
  username: "postgres",
  password: "postgres",
  database: "flix_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :flix, FlixWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Set configuration for image upload.
config :waffle,
  storage: Waffle.Storage.Local,
  asset_host: "http://localhost:4000"

# Set configuation for sending e-mail.
config :flix, Flix.Mailer, adapter: Bamboo.TestAdapter
