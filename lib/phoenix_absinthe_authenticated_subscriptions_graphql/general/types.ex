defmodule PhoenixAbsintheAuthenticatedSubscriptionsGraphQL.General.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  import_types(Absinthe.Type.Custom)

  object :timestamps do
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end

  object :response do
    field :code, non_null(:string)
    field :message, non_null(:string)
  end
end
