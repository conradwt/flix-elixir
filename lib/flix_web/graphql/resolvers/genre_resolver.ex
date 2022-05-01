defmodule FlixWeb.GraphQL.Resolvers.GenreResolver do
  alias Flix.Catalogs

  def list_genres(%Flix.Catalogs.Movie{} = movie, _args, _resolution) do
    {:ok, Catalogs.list_genres(movie)}
  end
end
