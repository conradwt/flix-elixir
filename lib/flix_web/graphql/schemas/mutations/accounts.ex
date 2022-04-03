defmodule FlixWeb.GraphQL.Schemas.Mutations.Accounts do
  use Absinthe.Schema.Notation

  alias FlixWeb.GraphQL.Resolvers

  object :user_mutations do
    @desc "Create a user account"
    field :signup, :session do
      arg :name, non_null(:string)
      arg :email, non_null(:string)
      arg :username, non_null(:string)
      arg :password, non_null(:string)
      resolve &Resolvers.Accounts.signup/3
    end

    @desc "Sign in a user"
    field :signin, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      resolve &Resolvers.Accounts.signin/3
    end
  end
end
