defmodule FlixWeb.GraphQL.Types.Genre do
  use Absinthe.Schema.Notation

  @desc "a genre"
  object :genre do
    @desc "unique identifier for the genre"
    field :id, non_null(:string)

    @desc "name of a genre"
    field :name, non_null(:string)
  end
end
