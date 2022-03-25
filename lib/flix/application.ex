defmodule Flix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Flix.Repo,
      # Start the Telemetry supervisor
      FlixWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, [name: Flix.PubSub, adapter: Phoenix.PubSub.PG2]},
      # Start the Endpoint (http/https)
      FlixWeb.Endpoint,
      # Start a worker by calling: Flix.Worker.start_link(arg)
      # {Flix.Worker, arg}
      {Absinthe.Subscription, FlixWeb.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Flix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FlixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
