defmodule Flix.Repo.Migrations.AddImageFileNameToMovies do
  use Ecto.Migration

  def change do
    alter table(:movies) do
      add :main_image, :string, default: "placeholder.png"
    end
  end
end
