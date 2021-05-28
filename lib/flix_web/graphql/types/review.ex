defmodule FlixWeb.Graphql.Types.Review do
  use Absinthe.Schema.Notation

  alias FlixWeb.Graphql.Resolvers

  @desc "a review"
  object :review do
    @desc "unique identifier for the review"
    field :id, non_null(:string)

    @desc "stars of a review"
    field :stars, non_null(:integer)

    @desc "comment of a review"
    field :comment, non_null(:string)
  end
end
