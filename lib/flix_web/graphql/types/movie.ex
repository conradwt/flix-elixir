defmodule FlixWeb.Graphql.Types.Movie do
  use Absinthe.Schema.Notation

  import_types Absinthe.Type.Custom

  alias FlixWeb.Graphql.Resolvers

  @desc "a movie"
  object :movie do
    @desc "unique identifier for the movie"
    field :id, non_null(:string)

    @desc "description of a movie"
    field :description, non_null(:string)

    @desc "director of a movie"
    field :director, non_null(:string)

    @desc "duration of a movie"
    field :duration, non_null(:string)

    @desc "poster url of the movie"
    field :poster_url, non_null(:string) do
      resolve fn movie, _args, _info ->
        {:ok, Flix.MainImageUploader.url({movie.main_image, movie}, :thumb, signed: true)}
      end
    end

    @desc "rating of a movie"
    field :rating, non_null(:string)

    @desc "released on of a movie"
    field :released_on, non_null(:date)

    @desc "slug of a movie"
    field :slug, non_null(:string)

    @desc "title of a movie"
    field :title, non_null(:string)

    @desc "total gross of a movie"
    field :total_gross, non_null(:decimal)

    # @desc "main image of a movie"
    # field(:main_image, non_null(:string))

    @desc "a list of genres for our movie"
    field :genres, list_of(:genre) do
      resolve &Resolvers.GenreResolver.list_genres/3
    end

    @desc "a list of reviews for our movie"
    field :reviews, list_of(:review) do
      resolve &Resolvers.ReviewResolver.list_reviews/3
    end
  end
end
