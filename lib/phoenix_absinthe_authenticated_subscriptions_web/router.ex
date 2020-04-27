defmodule PhoenixAbsintheAuthenticatedSubscriptionsWeb.Router do
  use PhoenixAbsintheAuthenticatedSubscriptionsWeb, :router

  pipeline :graphql do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :put_secure_browser_headers
    plug PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Context
  end

  scope "/v1" do
    pipe_through :graphql

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Schema,
      socket: PhoenixAbsintheAuthenticatedSubscriptionsWeb.UserSocket

    forward "/graphql", Absinthe.Plug,
      schema: PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Schema,
      before_send: {PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Context, :before_send}
  end
end
