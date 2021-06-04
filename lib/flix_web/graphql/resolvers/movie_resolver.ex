defmodule FlixWeb.Graphql.Resolvers.MovieResolver do
  alias Flix.Catalogs
  alias Flix.Catalogs.Movie
  alias Flix.Repo

  def get_movie(_root, %{id: id}, _info) do
    case Movie |> Repo.get_by(id: id) do
      nil  -> {:error, "Movie id \'#{id}\' not found"}
      movie -> {:ok, movie}
    end
  end

  def list_movies(_root, %{filter: filter}, _info) do
    {:ok, Catalogs.list_movies(filter) }
  end
end
