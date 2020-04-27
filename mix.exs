defmodule PhoenixAbsintheAuthenticatedSubscriptions.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_absinthe_authenticated_subscriptions,
      version: "0.1.0",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      test_paths: ["test"],
      test_pattern: "**/*_test.exs",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "check.linter": :test,
        "check.code.format": :test,
        "check.code.security": :test,
        "check.code.coverage": :test
      ],
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PhoenixAbsintheAuthenticatedSubscriptions.Application, []},
      extra_applications: [:logger, :runtime_tools]
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
      # Phoenix
      {:phoenix, "~> 1.4.6"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:jason, "~> 1.0"},

      # Server
      {:plug_cowboy, "~> 2.0"},
      {:cors_plug, "~> 2.0"},

      # GraphQL
      {:absinthe, "~> 1.5.0-rc.4"},
      {:absinthe_plug, "~> 1.5.0-rc.2"},
      {:absinthe_phoenix, "~> 1.5.0-rc.0"},

      # Database
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},

      # Translations
      {:gettext, "~> 0.17"},

      # Encryption
      {:bcrypt_elixir, "~> 2.1.0"},

      # Linting
      {:credo, "~> 1.1", only: [:dev, :test], override: true},
      {:credo_envvar, "~> 0.1", only: [:dev, :test], runtime: false},
      {:credo_naming, "~> 0.4", only: [:dev, :test], runtime: false},

      # Security check
      {:sobelow, "~> 0.9", only: [:dev, :test], runtime: true},

      # Test factories
      {:ex_machina, "~> 2.3", only: :test},
      {:faker, "~> 0.13", only: :test},

      # Test coverage
      {:excoveralls, "~> 0.12", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      compile: ["compile --warnings-as-errors"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      "check.linter": ["credo --strict"],
      "check.code.format": ["format --dry-run --check-formatted"],
      "check.code.security": ["sobelow --config"],
      "check.code.coverage": ["coveralls"]
    ]
  end
end
