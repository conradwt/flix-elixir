defmodule Flix.Catalogs.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  alias Flix.Accounts.User
  alias Flix.Catalogs.Movie

  schema "favorites" do
    belongs_to :user, User
    belongs_to :movie, Movie

    timestamps()
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:movie_id, :user_id])
    |> validate_required([:movie_id, :user_id])

    # |> assoc_constraint(:movie)
    # |> assoc_constraint(:user)
  end
end
