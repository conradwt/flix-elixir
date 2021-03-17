defmodule Flix.Catalogs.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field :description, :string
    field :director, :string
    field :duration, :string
    field :rating, :string
    field :released_on, :date
    field :slug, :string
    field :title, :string
    field :total_gross, :decimal

    timestamps()
  end

  def ratings, do: ["G", "PG", "PG-13", "R", "NC-17"]

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [
      :title,
      :rating,
      :total_gross,
      :description,
      :released_on,
      :director,
      :duration,
      :slug
    ])
    |> validate_required([
      :title,
      :rating,
      :total_gross,
      :description,
      :released_on,
      :director,
      :duration,
      :slug
    ])
    |> unique_constraint(:title)
    |> validate_length(:description, min: 25)
    |> validate_number(:total_gross, greater_than_or_equal_to: 0)
    |> validate_inclusion(:rating, ratings())
  end
end
