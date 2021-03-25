defmodule Flix.Catalogs.Genre do
  use Ecto.Schema
  import Ecto.Changeset

  alias Flix.Catalogs.Characterization

  schema "genres" do
    field :name, :string

    has_many :characterizations, Characterization
    has_many :movies, through: [:characterizations, :movie]

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
