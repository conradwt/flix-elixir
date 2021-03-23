defmodule Flix.Catalogs.Movie do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

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

  def flops(query) do
    from movie in query,
      where: movie.total_gross < 225_000_000
  end

  def grossed_greater_than(query, amount) do
    from movie in query,
      where: movie.total_gross > ^amount
  end

  def grossed_less_than(query, amount) do
    from movie in query,
      where: movie.total_gross < ^amount
  end

  def hits(query) do
    from movie in query,
      where: movie.total_gross >= 300_000_000,
      order_by: [desc: movie.total_gross]
  end

  def recent(query, max_number \\ 5) do
    from movie in query,
      where: movie.released_on < ^Date.utc_today(),
      order_by: [desc: movie.released_on],
      limit: ^max_number
  end

  def released(query) do
    from movie in query,
      where: movie.released_on < ^Date.utc_today(),
      order_by: [desc: movie.released_on]
  end

  def upcoming(query) do
    from movie in query,
      where: movie.released_on > ^Date.utc_today(),
      order_by: [asc: movie.released_on]
  end

  def flop?(movie) do
    movie.total_gross < 225_000_000
  end

  def created(query) do
    from movie in query,
      order_by: [:desc, movie.created_at],
      limit: 3
  end

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
