defmodule FlixWeb.Graphql.Schemas.Queries.Movie do
  use Absinthe.Schema.Notation

  alias FlixWeb.Graphql.Resolvers.MovieResolver

  object :movie_queries do
    @desc "get a single movie"
    field :movie, :movie do
      arg :slug, non_null(:string)

      resolve &MovieResolver.get_movie/3
    end

    @desc "list all movies"
    field :movies, list_of(:movie) do
      arg :filter, :string, default_value: nil

      resolve &MovieResolver.list_movies/3
    end
  end
end
