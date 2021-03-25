defmodule Flix.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :stars, :integer
      add :comment, :text
      add :movie_id, references(:movies, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:reviews, [:movie_id])
    create index(:reviews, [:user_id])
  end
end
