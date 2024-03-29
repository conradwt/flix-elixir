defmodule Flix.Catalogs.Genre do
  use Ecto.Schema
  import Ecto.Changeset

  alias Flix.Catalogs.{Characterization, Movie}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "genres" do
    field(:name, :string)

    many_to_many(:movies, Movie, join_through: Characterization)

    timestamps()
  end

  @doc false
  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
