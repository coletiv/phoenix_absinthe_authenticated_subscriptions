defmodule PhoenixAbsintheAuthenticatedSubscriptions.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_absinthe_authenticated_subscriptions,
    adapter: Ecto.Adapters.Postgres
end
