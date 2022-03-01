import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :flix, Flix.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "flix_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :flix, FlixWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Uto9n7wOoq5JuJushLaaAPX67NTJTulsxF+wSQL2uiu24ySLwAxlwfrETCxPwa/D",
  server: false

# In test we don't send emails.
config :flix, Flix.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Set configuration for image upload.
config :waffle,
  storage: Waffle.Storage.Local,
  asset_host: "http://localhost:4000"

# Set configuation for sending e-mail.
config :flix, Flix.Mailer, adapter: Bamboo.TestAdapter
