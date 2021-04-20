defmodule Flix.Repo.Migrations.AddSlugIndexToMovies do
  use Ecto.Migration

  def change do
    create(unique_index(:movies, [:slug]))
  end
end
