defmodule Flix.Catalogs.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  alias Flix.Accounts.User
  alias Flix.Catalogs.Movie

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "favorites" do
    belongs_to :user, User
    belongs_to :movie, Movie

    timestamps()
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:movie_id, :user_id])
    |> validate_movie_id
    |> validate_user_id
  end

  defp validate_movie_id(changeset) do
    changeset
    |> validate_required([:movie_id])
  end

  defp validate_user_id(changeset) do
    changeset
    |> validate_required([:user_id])
  end
end
