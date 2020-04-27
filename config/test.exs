use Mix.Config

# Configure your database
config :phoenix_absinthe_authenticated_subscriptions, PhoenixAbsintheAuthenticatedSubscriptions.Repo,
  username: "postgres",
  password: "postgres",
  database: "phoenix_absinthe_authenticated_subscriptions_test",
  hostname: System.get_env("REPO_HOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_absinthe_authenticated_subscriptions, PhoenixAbsintheAuthenticatedSubscriptionsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
