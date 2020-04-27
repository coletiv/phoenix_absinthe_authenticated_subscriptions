defmodule PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Middleware.Session do
  @moduledoc false
  @behaviour Absinthe.Middleware

  def call(resolution, action) do
    with %{value: %{user: user}} <- resolution do
      Map.update!(resolution, :context, fn ctx ->
        ctx
        |> Map.put(:user_id, user.id)
        |> Map.put(:user_action, action)
      end)
    end
  end
end
