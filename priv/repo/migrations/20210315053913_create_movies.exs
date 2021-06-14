defmodule Flix.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :title, :string
      add :rating, :string
      add :total_gross, :decimal
      add :description, :text
      add :released_on, :date
      add :director, :string
      add :duration, :string
      add :slug, :string

      timestamps()
    end
  end
end
