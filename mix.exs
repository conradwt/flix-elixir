defmodule Flix.MixProject do
  use Mix.Project

  def project do
    [
      app: :flix,
      version: "0.1.0",
      elixir: "~> 1.15.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      preferred_cli_env: [
        "test.watch": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Flix.Application, []},
      extra_applications: [:logger, :runtime_tools, :phoenix_html_simplified_helpers]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6.16"},
      {:phoenix_ecto, "~> 4.4.2"},
      {:ecto_sql, "~> 3.10.1"},
      {:postgrex, "~> 0.17.1"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.3.3", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.5"},
      {:esbuild, "~> 0.7.0", runtime: Mix.env() == :dev},
      {:dart_sass, "~> 0.6.0", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6.1"},
      {:telemetry_poller, "~> 1.0.0"},
      {:gettext, "~> 0.18.2"},
      {:jason, "~> 1.3.0"},
      {:plug_cowboy, "~> 2.5.2"},
      {:absinthe_plug, "~> 1.5.8"},
      {:cors_plug, "~> 3.0.3"},
      {:bcrypt_elixir, "~> 2.0"},
      {:number, "~> 1.0"},
      {:phoenix_html_simplified_helpers, "~> 2.1"},
      {:phoenix_mtm, git: "https://github.com/adam12/phoenix_mtm"},
      {:waffle, "~> 1.1.7"},
      {:waffle_ecto, "~> 0.0.12"},
      {:ex_aws, "~> 2.1.2"},
      {:ex_aws_s3, "~> 2.0"},
      {:hackney, "~> 1.9"},
      {:sweet_xml, "~> 0.6"},
      {:ex_parameterize, "~> 1.0"},
      {:bamboo, "~> 2.1.0"},
      {:bamboo_phoenix, "~> 1.0"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:mix_test_watch, "~> 1.1", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.build": [
        "esbuild default",
        "sass default",
        "tailwind default"
      ],
      "assets.deploy": [
        "esbuild default --minify",
        "sass default --no-source-map --style=compressed",
        "tailwind default --minify",
        "phx.digest"
      ]
    ]
  end
end
