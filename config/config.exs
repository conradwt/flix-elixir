# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :flix,
  ecto_repos: [Flix.Repo]

# Configures the endpoint
config :flix, FlixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Qt6jNFqOcdT4QKhGLOeGTeCfBC5tUHw60YRObw4S5GNsJyVZaS5vmj3oG1Z7z/MD",
  render_errors: [view: FlixWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Flix.PubSub,
  live_view: [signing_salt: "ak55khA3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure the time zone database.
# https://mikezornek.com/posts/2020/3/working-with-time-zones-in-an-elixir-phoenix-app
# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Configure Bamboo Mailer
config :flix, Flix.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")

# Configure mix_test_watch
if Mix.env == :dev do
  config :mix_test_watch,
    clear: true,
    tasks: [
      "test",
      "credo",
    ]
end

# Configure Absinthe SDL/JSON code generation.
config :absinthe,
  schema: FlixWeb.Graphql.Schema

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
