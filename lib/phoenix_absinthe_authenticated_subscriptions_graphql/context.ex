defmodule PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Context do
  @moduledoc false

  import Plug.Conn

  import Absinthe.Plug

  def init(opts), do: opts

  def call(conn, _) do
    put_options(conn, context: build_context(conn))
  end

  defp build_context(conn) do
    case get_session(conn, :user_id) do
      nil ->
        %{}

      user_id ->
        %{current_user: get_user(user_id)}
    end
  end

  defp get_user(user_id) do
    PhoenixAbsintheAuthenticatedSubscriptions.Accounts.lookup_user(user_id)
  end

  def before_send(conn, %Absinthe.Blueprint{} = blueprint) do
    case blueprint.execution.context[:user_action] do
      :login ->
        user_id = blueprint.execution.context[:user_id]
        put_session(conn, :user_id, user_id)

      :logout ->
        delete_session(conn, :user_id)

      _ ->
        conn
    end
  end

  def before_send(conn, _), do: conn
end
