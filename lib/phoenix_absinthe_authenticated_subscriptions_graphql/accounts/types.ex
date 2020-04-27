defmodule PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Accounts.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Middleware

  alias PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Accounts.Resolver

  alias PhoenixAbsintheAuthenticatedSubscriptions.General.Responses

  object :session do
    field :user, :user
    field :token, :string
  end

  object :user do
    field :id, :id
    field :email, :string
    field :name, :string

    import_fields(:timestamps)
  end

  object :accounts_queries do
    field :accounts_all_users, non_null(list_of(non_null(:user))) do
      middleware(Middleware.Authorize, :any)

      resolve(&Resolver.all_users/3)
    end

    field :accounts_me, :session do
      resolve(&Resolver.me/3)
    end
  end

  object :accounts_mutations do
    field :accounts_login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolver.login/3)

      middleware(Middleware.Session, :login)
    end

    field :accounts_logout, :session do
      middleware(Middleware.Authorize, :any)

      resolve(&Resolver.logout/3)

      middleware(Middleware.Session, :logout)
    end

    field :accounts_register, :response do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolver.register/3)
    end
  end

  object :accounts_subscriptions do
    field :accounts_user_count, :integer do
      config(fn
        _args, %{context: %{current_user: %{id: user_id}}} ->
          {:ok, topic: "user_count:#{user_id}"}

        _args, _context ->
          {:error, Responses.get(:user_unauthorized)}
      end)

      resolve(fn value, _, _res ->
        {:ok, value}
      end)
    end
  end
end
