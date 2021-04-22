defmodule FlixWeb.FavoriteController do
  use FlixWeb, :controller

  import FlixWeb.UserAuth, only: [require_authenticated_user: 2]

  plug(:require_authenticated_user when action in [:create, :delete])
  plug(:put_movie)

  alias Flix.Catalogs

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"favorite" => favorite_params}) do
    %{movie: movie} = conn.assigns
    current_user = conn.assigns.current_user

    case Catalogs.create_favorite(
           favorite_params
           |> Map.merge(%{movie_id: movie.id, user_id: current_user.id})
         ) do
      {:ok, _favorite} ->
        conn
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create(conn, _) do
    %{movie: movie} = conn.assigns
    current_user = conn.assigns.current_user

    favorite_params = %{movie_id: movie.id, user_id: current_user.id}

    case Catalogs.create_favorite(favorite_params) do
      {:ok, _favorite} ->
        conn
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    %{movie: movie} = conn.assigns
    # current_user = conn.assigns.current_user

    favorite = Catalogs.get_favorite!(id)

    {:ok, _favorite} = Catalogs.delete_favorite(favorite)

    conn
    |> redirect(to: Routes.movie_path(conn, :show, movie))
  end

  defp put_movie(conn, _opts) do
    movie = Catalogs.get_movie!(conn.params["movie_id"])
    assign(conn, :movie, movie)
  end
end
