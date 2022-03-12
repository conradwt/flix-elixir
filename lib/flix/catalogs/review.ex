defmodule Flix.Catalogs.Review do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Flix.Accounts.User
  alias Flix.Catalogs.Movie

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reviews" do
    field :comment, :string
    field :stars, :integer

    belongs_to :movie, Movie
    belongs_to :user, User

    timestamps()
  end

  def stars, do: [1, 2, 3, 4, 5]

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:stars, :comment, :movie_id, :user_id])
    |> validate_comment
    |> validate_movie_id
    |> validate_stars
    |> validate_user_id
    |> unique_constraint([:movie_id, :user_id], message:
    "already has a review from user")
  end

  defp validate_comment(changeset) do
    changeset
    |> validate_required([:comment])
    |> validate_length(:comment, min: 4)
  end

  def validate_movie_id(changeset) do
    changeset
    |> validate_required([:movie_id])
  end

  defp validate_stars(changeset) do
    changeset
    |> validate_required([:stars])
    |> validate_inclusion(:stars, stars(), message: "must be between 1 and 5")
  end

  def validate_user_id(changeset) do
    changeset
    |> validate_required([:user_id])
  end

  def past_n_days(query, number) do
    from(review in query,
      where: review.inserted_at >= ago(^number, "day")
    )
  end

  def stars_as_percent(review) do
    review.stars / 5.0 * 100.0
  end
end
