defmodule Flix.Repo.Migrations.AddUniqueIndexToReviews do
  use Ecto.Migration

  def change do
    create unique_index(:reviews, [:movie_id, :user_id])
  end
end
