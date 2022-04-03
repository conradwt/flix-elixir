defmodule FlixWeb.GraphQL.Resolvers.ReviewResolver do
  alias Flix.Catalogs

  def list_reviews(%Flix.Catalogs.Movie{} = movie, _args, _resolution) do
    {:ok, Catalogs.list_reviews(movie)}
  end
end
