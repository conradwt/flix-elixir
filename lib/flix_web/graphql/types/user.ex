defmodule FlixWeb.Graphql.Types.User do
  use Absinthe.Schema.Notation

  @desc "a user"
  object :user do
    @desc "unique identifier for the user"
    field(:id, non_null(:string))

    @desc "name of a user"
    field(:name, non_null(:string))

    @desc "email of a user"
    field(:email, non_null(:string))

    @desc "username of a user"
    field(:username, non_null(:string))
  end
end
