defmodule PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Middleware.Errors do
  @moduledoc false
  @behaviour Absinthe.Middleware

  def call(%{errors: [%Ecto.Changeset{} = changeset]} = resolution, _) do
    errors =
      changeset
      |> Ecto.Changeset.traverse_errors(&format_error/1)
      |> Enum.map(fn {k, v} -> %{code: k, message: v} end)

    %{
      resolution
      | errors: errors
    }
  end

  def call(resolution, _), do: resolution

  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
