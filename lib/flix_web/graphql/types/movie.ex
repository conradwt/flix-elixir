defmodule FlixWeb.Graphql.Types.Movie do
  use Absinthe.Schema.Notation

  import_types Absinthe.Type.Custom

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

    # @desc "a list of friends for our person"
    # field :friends, list_of(:person) do
    #   resolve(fn _, %{source: person} ->
    #     {:ok, Repo.all(assoc(person, :friends))}
    #   end)
    # end
  end
end
