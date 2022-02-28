defmodule FlixWeb.GraphQL.Schemas.Queries.Movie do
  use Absinthe.Schema.Notation

  alias FlixWeb.GraphQL.Resolvers.MovieResolver

  object :movie_queries do
    @desc "get a single movie"
    field :movie, :movie do
      arg :id, non_null(:id)

      resolve(&MovieResolver.get_movie/3)
    end

    @desc "list all movies"
    field :movies, list_of(:movie) do
      arg(:filter, :string, default_value: nil)

      resolve(&MovieResolver.list_movies/3)
    end
  end
end
