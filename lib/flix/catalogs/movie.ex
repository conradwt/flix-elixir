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
    field :main_image, :string

    timestamps()
  end

  def ratings, do: ~w(G PG PG-13 R NC-17)

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
      :slug,
      :main_image
    ])
    |> validate_required([
      :title,
      :rating,
      :total_gross,
      :description,
      :released_on,
      :director,
      :duration
    ])
    |> unique_constraint(:title)
    |> validate_length(:description, min: 25)
    |> validate_number(:total_gross, greater_than_or_equal_to: 0)
    |> validate_inclusion(:rating, ratings())
  end

  def flop?(movie) do
    movie.total_gross < 225_000_000
  end

  # def self.created do
  #   order(created_at: :desc).limit(3)
  # end

  # def average_stars_as_percent do
  #   average_stars / 5.0 * 100
  # end

  # def average_stars do
  #   reviews.average(:stars) || 0.0
  # end

  # TODO: remove as this will be taken care of
  # defp to_param do
  #   slug
  # end
end
