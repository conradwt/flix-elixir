defmodule FlixWeb.GraphQL.Schemas.Queries.User do
  use Absinthe.Schema.Notation

  alias FlixWeb.GraphQL.Resolvers.UserResolver

  object :user_queries do
    @desc "get a single user"
    field :user, :user do
      arg(:id, non_null(:id))

      resolve(&UserResolver.get_user/3)
    end

    @desc "list all users"
    field :users, list_of(:user) do
      resolve(&UserResolver.list_users/3)
    end
  end
end
