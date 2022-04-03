defmodule FlixWeb.GraphQL.Resolvers.UserResolver do
  alias Flix.Accounts
  alias Flix.Accounts.User
  alias Flix.Repo

  def get_user(_parent, %{id: id}, _resolution) do
    case User |> Repo.get(id) do
      nil -> {:error, "User id \"#{id}\" not found"}
      user -> {:ok, user}
    end
  end

  def list_users(_parent, _args, _resolution) do
    {:ok, Accounts.list_users()}
  end
end
