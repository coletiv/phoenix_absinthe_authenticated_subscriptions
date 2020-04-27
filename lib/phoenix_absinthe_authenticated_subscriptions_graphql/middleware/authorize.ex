defmodule PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Middleware.Authorize do
  @moduledoc false
  @behaviour Absinthe.Middleware

  alias PhoenixAbsintheAuthenticatedSubscriptions.General.Responses

  def call(resolution, role) do
    with true <- correct_role?("any", Atom.to_string(role) || "any") do
      resolution
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, Responses.get(:user_unauthorized)})
    end
  end

  defp correct_role?(_, "any"), do: true
  defp correct_role?(role, role), do: true
  defp correct_role?(_, _), do: false
end
