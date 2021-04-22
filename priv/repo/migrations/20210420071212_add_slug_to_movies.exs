defmodule Flix.Repo.Migrations.AddSlugToMovies do
  use Ecto.Migration

  import Parameterize

  alias Flix.Catalogs.Movie
  alias Flix.Repo

  def change do
    slugify_movie = fn movie ->
      slug = parameterize(movie.title)
      movie_params = %{"slug" => slug}
      changeset = Movie.changeset(movie, movie_params)
      Repo.update(changeset)
    end

    movies = Repo.all(Movie)

    Enum.map(movies, slugify_movie)
  end
end
