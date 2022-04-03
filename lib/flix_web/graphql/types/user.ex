defmodule FlixWeb.GraphQL.Types.User do
  use Absinthe.Schema.Notation

  alias Flix.Accounts.User

  @desc "a user"
  object :user do
    @desc "unique identifier for the user"
    field :id, non_null(:id)

    @desc "avatar url for the user"
    field :avatar_url, non_null(:string) do
      arg(:size, :integer, default_value: 100)

      resolve(fn user, %{size: size}, _info ->
        {:ok, "https://www.gravatar.com/avatar/#{User.gravatar_id(user)}?s=#{size}&d=robohash"}
      end)
    end

    @desc "name for the user"
    field :name, non_null(:string)

    @desc "email for the user"
    field :email, non_null(:string)

    @desc "member since for the user"
    field :member_since, non_null(:string) do
      resolve fn user, _args, _info ->
        {:ok, user.inserted_at |> Calendar.strftime("%B %Y")}
      end
    end

    @desc "username for the user"
    field :username, non_null(:string)
  end
end
