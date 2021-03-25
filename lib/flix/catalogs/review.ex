defmodule Flix.Catalogs.Review do
  use Ecto.Schema
  import Ecto.Changeset

  alias Flix.Accounts.User
  alias Flix.Catalogs.Movie

  schema "reviews" do
    field :comment, :string
    field :stars, :integer

    belongs_to :movie, Movie
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:stars, :comment, :movie_id, :user_id])
    |> validate_required([:stars, :comment, :movie_id, :user_id])

    # |> assoc_constraint(:movie)
    # |> assoc_constraint(:user)
  end
end
