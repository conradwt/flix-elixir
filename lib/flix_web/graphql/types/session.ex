defmodule FlixWeb.GraphQL.Types.Session do
  use Absinthe.Schema.Notation

  object :session do
    field :user, non_null(:user)
    field :token, non_null(:string)
  end
end
