defmodule Flix.Repo.Migrations.CreateCharacterizations do
  use Ecto.Migration

  def change do
    create table(:characterizations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :movie_id, references(:movies, type: :binary_id, on_delete: :delete_all)
      add :genre_id, references(:genres, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end

    create index(:characterizations, [:movie_id])
    create index(:characterizations, [:genre_id])
  end
end
