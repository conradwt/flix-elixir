defmodule Flix.Repo.Migrations.CreateFavorites do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :movie_id, references(:movies, on_delete: :delete_all)

      timestamps()
    end

    create index(:favorites, [:user_id])
    create index(:favorites, [:movie_id])
  end
end
