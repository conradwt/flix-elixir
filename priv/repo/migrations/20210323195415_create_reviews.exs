defmodule Flix.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :stars, :integer
      add :comment, :text
      add :movie_id, references(:movies, type: :binary_id, on_delete: :delete_all), null: false
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:reviews, [:movie_id])
    create index(:reviews, [:user_id])
  end
end
