use Mix.Config

# Configure your database
config :phoenix_absinthe_authenticated_subscriptions, PhoenixAbsintheAuthenticatedSubscriptions.Repo,
  username: "postgres",
  password: "postgres",
  database: "phoenix_absinthe_authenticated_subscriptions_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
