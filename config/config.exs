# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :flix,
  ecto_repos: [Flix.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :flix, FlixWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: FlixWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Flix.PubSub,
  live_view: [signing_salt: "C/wWe4Zy"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :flix, Flix.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

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

# Configure Mix Test Watch
if Mix.env == :dev do
  config :mix_test_watch,
    clear: true,
    tasks: [
      "test",
      "credo"
    ]
end

# Configure Absinthe SDL/JSON code generation.
# config :absinthe,
#   schema: FlixWeb.GraphQL.Schema

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
