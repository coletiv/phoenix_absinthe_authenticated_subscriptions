defmodule PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.Application.Types do
  @moduledoc """
  Application Types
  """
  use Absinthe.Schema.Notation

  object :application do
    @desc "The application version"
    field(:version, :string)
  end

  object :application_queries do
    @desc "Application information"
    field :application, :application do
      resolve(fn _, _, _ ->
        {:ok, %{version: version()}}
      end)
    end
  end

  defp version, do: Application.spec(:phoenix_absinthe_authenticated_subscriptions, :vsn)
end
