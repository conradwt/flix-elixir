defmodule Flix.Catalogs.Movie do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Flix.Catalogs.{Favorite, Review, Characterization}
  alias Flix.Repo

  schema "movies" do
    field(:description, :string)
    field(:director, :string)
    field(:duration, :string)
    field(:rating, :string)
    field(:released_on, :date)
    field(:slug, :string)
    field(:title, :string)
    field(:total_gross, :decimal)
    field(:main_image, :string)

    has_many(:reviews, Review)
    has_many(:favorites, Favorite)
    # TODO: In Rails: has_many :fans, through: :favorites, source: :user
    has_many(:fans, through: [:favorites, :user])
    has_many(:characterizations, Characterization)
    has_many(:genres, through: [:characterizations, :genre])

    timestamps()
  end

  @doc false
  def filters, do: ~w(released upcoming recent hits flops)

  @doc false
  def ratings, do: ~w(G PG PG-13 R NC-17)

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [
      :description,
      :director,
      :duration,
      :main_image,
      :rating,
      :released_on,
      :slug,
      :title,
      :total_gross
    ])
    |> validate_description(min: 25)
    |> validate_director
    |> validate_duration
    |> validate_main_image
    |> validate_rating(ratings())
    |> validate_released_on
    |> validate_slug
    |> validate_title
    |> validate_total_gross(greater_than_or_equal_to: 0)
  end

  defp validate_description(changeset, options) do
    changeset
    |> validate_required([:description])
    |> validate_length(:description, options)
  end

  defp validate_director(changeset) do
    changeset
    |> validate_required([:director])
  end

  defp validate_duration(changeset) do
    changeset
    |> validate_required([:duration])
  end

  defp validate_main_image(changeset) do
    changeset
    |> validate_required([:main_image])
  end

  defp validate_rating(changeset, options) do
    changeset
    |> validate_required([:rating])
    |> validate_inclusion(:rating, options)
  end

  defp validate_released_on(changeset) do
    changeset
    |> validate_required([:released_on])
  end

  defp validate_slug(changeset) do
    changeset
  end

  defp validate_title(changeset) do
    changeset
    |> validate_required([:title])
    |> unique_constraint(:title)
  end

  defp validate_total_gross(changeset, options) do
    changeset
    |> validate_required([:total_gross])
    |> validate_number(:total_gross, options)
  end

  @doc false
  def flops(query) do
    from(movie in query,
      where: movie.total_gross < 225_000_000
    )
  end

  @doc false
  def grossed_greater_than(query, amount) do
    from(movie in query,
      where: movie.total_gross > ^amount
    )
  end

  @doc false
  def grossed_less_than(query, amount) do
    from(movie in query,
      where: movie.total_gross < ^amount
    )
  end

  @doc false
  def hits(query) do
    from(movie in query,
      where: movie.total_gross >= 300_000_000,
      order_by: [desc: movie.total_gross]
    )
  end

  @doc false
  def recent(query, max_number \\ 5) do
    from(movie in query,
      where: movie.released_on < ^Date.utc_today(),
      order_by: [desc: movie.released_on],
      limit: ^max_number
    )
  end

  @doc false
  def released(query) do
    from(movie in query,
      where: movie.released_on < ^Date.utc_today(),
      order_by: [desc: movie.released_on]
    )
  end

  @doc false
  def upcoming(query) do
    from(movie in query,
      where: movie.released_on > ^Date.utc_today(),
      order_by: [asc: movie.released_on]
    )
  end

  @doc false
  def flop?(movie) do
    movie.total_gross < 225_000_000
  end

  @doc false
  def created(query) do
    from(movie in query,
      order_by: [:desc, movie.created_at],
      limit: 3
    )
  end

  def average_stars_as_percent(movie) do
    average = movie |> average_stars()
    average / 5.0 * 100
  end

  def average_stars(movie) do
    movie = movie |> Repo.preload(:reviews)

    if Enum.empty?(movie.reviews) do
      0.0
    else
      Repo.one(
        from(r in Review,
          where: ^movie.id == r.movie_id,
          select: avg(r.stars)
        )
      )
      |> Decimal.to_float()
    end
  end

  # TODO: remove as this will be taken care of
  # defp to_param do
  #   slug
  # end
end
