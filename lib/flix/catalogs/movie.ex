defmodule Flix.Catalogs.Movie do
  use Ecto.Schema
  use Waffle.Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  import Parameterize

  alias Flix.Catalogs.{Favorite, Genre, Review, Characterization}
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
    field(:main_image, Flix.MainImageUploader.Type)

    has_many(:reviews, Review)
    has_many(:favorites, Favorite)
    # TODO: In Rails: has_many :fans, through: :favorites, source: :user
    has_many(:fans, through: [:favorites, :user])

    # has_many(:characterizations, Characterization)
    # has_many(:genres, through: [:characterizations, :genre])
    # https://hexdocs.pm/phoenix_mtm/PhoenixMTM.Changeset.html
    many_to_many(:genres, Genre,
      join_through: Characterization,
      on_replace: :delete,
      on_delete: :delete_all
    )

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
      :rating,
      :released_on,
      :slug,
      :title,
      :total_gross
    ])
    |> validate_description
    |> validate_director
    |> validate_duration
    |> validate_genres
    |> validate_rating
    |> validate_released_on
    |> validate_title
    |> validate_total_gross
  end

  defp validate_description(changeset) do
    changeset
    |> validate_required(:description)
    |> validate_length(:description, min: 25)
  end

  defp validate_director(changeset) do
    changeset
    |> validate_required(:director)
  end

  defp validate_duration(changeset) do
    changeset
    |> validate_required(:duration)
  end

  defp validate_genres(changeset) do
    changeset
    |> PhoenixMTM.Changeset.cast_collection(:genres, fn ids ->
      # Convert Strings back to Integers
      ids = Enum.map(ids, &String.to_integer/1)
      Repo.all(from(g in Genre, where: g.id in ^ids))
    end)
  end

  # defp validate_main_image(changeset) do
  #   changeset
  # end

  defp validate_rating(changeset) do
    changeset
    |> validate_required(:rating)
    |> validate_inclusion(:rating, ratings())
  end

  defp validate_released_on(changeset) do
    changeset
    |> validate_required(:released_on)
  end

  defp validate_title(changeset) do
    changeset
    |> slugify_title
    |> validate_required(:title)
    |> unique_constraint(:title)
  end

  defp validate_total_gross(changeset) do
    changeset
    |> validate_required(:total_gross)
    |> validate_number(:total_gross, greater_than_or_equal_to: 0)
  end

  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, new_title} ->
        put_change(changeset, :slug, parameterize(new_title))

      :error ->
        changeset
    end
  end

  def poster_changeset(movie, attrs) do
    movie
    |> cast_attachments(attrs, [:main_image])
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
end
