defmodule Flix.Repo.Migrations.CreateCharacterizations do
  use Ecto.Migration

  def change do
    create table(:characterizations) do
      add :movie_id, references(:movies, on_delete: :delete_all)
      add :genre_id, references(:genres, on_delete: :delete_all)

      timestamps()
    end

    create index(:characterizations, [:movie_id])
    create index(:characterizations, [:genre_id])
  end
end
