defmodule FlixWeb.Graphql.Resolvers.ReviewResolver do
  def list_reviews(%Flix.Catalogs.Movie{} = movie, _args, _resolution) do
    {:ok, Flix.Catalogs.list_reviews(movie)}
  end
end
