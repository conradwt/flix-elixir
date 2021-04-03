defmodule FlixWeb.FavoriteController do
  use FlixWeb, :controller

  import FlixWeb.UserAuth, only: [require_authenticated_user: 2]

  plug :require_authenticated_user when action in [:create, :delete]
  plug :put_movie

  alias Flix.Catalogs

  def create(conn, %{"favorite" => favorite_params}) do
    %{movie: movie} = conn.assigns

    case Catalogs.create_favorite(favorite_params) do
      {:ok, favorite} ->
        conn
        |> put_flash(:info, "Favorite created successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    %{movie: movie} = conn.assigns

    favorite = Catalogs.get_favorite!(id)
    {:ok, _favorite} = Catalogs.delete_favorite(favorite)

    conn
    |> put_flash(:info, "Favorite deleted successfully.")
    |> redirect(to: Routes.movie_path(conn, :show, movie))
  end

  defp put_movie(conn, _opts) do
    movie = Catalogs.get_movie!(conn.params["movie_id"])
    assign(conn, :movie, movie)
  end
end
