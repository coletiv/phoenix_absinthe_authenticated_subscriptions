defmodule PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Schema do
  @moduledoc """
  GraphQL Schema
  """
  use Absinthe.Schema

  alias PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Middleware

  import_types(Absinthe.Plug.Types)

  import_types(PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Application.Types)

  import_types(PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.General.Types)

  import_types(PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Accounts.Types)

  def middleware(middleware, _field, %{identifier: :mutation}),
    do: middleware ++ [Middleware.Errors]

  def middleware(middleware, _, _), do: middleware

  query do
    import_fields(:application_queries)
    import_fields(:accounts_queries)
  end

  mutation do
    import_fields(:accounts_mutations)
  end

  subscription do
    import_fields(:accounts_subscriptions)
  end
end
