defmodule FlixWeb.Graphql.Resolvers.MovieResolver do
  alias Flix.Catalogs
  alias Flix.Catalogs.Movie
  alias Flix.Repo

  def get_movie(_root, %{slug: slug}, _info) do
    case Movie |> Repo.get_by(slug: slug) do
      nil  -> {:error, "Movie slug \'#{slug}\' not found"}
      movie -> {:ok, movie}
    end
  end

  def list_movies(_root, %{filter: filter}, _info) do
    {:ok, Catalogs.list_movies(filter) }
  end
end
