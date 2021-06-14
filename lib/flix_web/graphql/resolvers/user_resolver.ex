defmodule FlixWeb.Graphql.Resolvers.UserResolver do
  alias Flix.Accounts
  alias Flix.Accounts.User
  alias Flix.Repo

  def get_user(_root, %{id: id}, _info) do
    case User |> Repo.get(id) do
      nil -> {:error, "User id \"#{id}\" not found"}
      user -> {:ok, user}
    end
  end

  def list_users(_root, _args, _info) do
    {:ok, Accounts.list_users()}
  end
end
