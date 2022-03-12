defmodule Flix.Catalogs.Characterization do
  use Ecto.Schema
  import Ecto.Changeset

  alias Flix.Catalogs.{Genre, Movie}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "characterizations" do
    belongs_to :movie, Movie
    belongs_to :genre, Genre

    timestamps()
  end

  @doc false
  def changeset(characterization, attrs) do
    characterization
    |> cast(attrs, [:movie_id, :genre_id])
    |> validate_required([:movie_id, :genre_id])

    # |> assoc_constraint(:movie)
    # |> assoc_constraint(:genre)
  end
end
