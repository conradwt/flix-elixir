defmodule FlixWeb.GenreController do
  use FlixWeb, :controller

  alias Flix.Catalogs
  alias Flix.Catalogs.Genre

  def index(conn, _params) do
    genres = Catalogs.list_genres()
    render(conn, "index.html", genres: genres)
  end

  def new(conn, _params) do
    changeset = Catalogs.change_genre(%Genre{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"genre" => genre_params}) do
    case Catalogs.create_genre(genre_params) do
      {:ok, genre} ->
        conn
        |> put_flash(:info, "Genre created successfully.")
        |> redirect(to: Routes.genre_path(conn, :show, genre))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    genre = Catalogs.get_genre!(id)
    render(conn, "show.html", genre: genre)
  end

  def edit(conn, %{"id" => id}) do
    genre = Catalogs.get_genre!(id)
    changeset = Catalogs.change_genre(genre)
    render(conn, "edit.html", genre: genre, changeset: changeset)
  end

  def update(conn, %{"id" => id, "genre" => genre_params}) do
    genre = Catalogs.get_genre!(id)

    case Catalogs.update_genre(genre, genre_params) do
      {:ok, genre} ->
        conn
        |> put_flash(:info, "Genre updated successfully.")
        |> redirect(to: Routes.genre_path(conn, :show, genre))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", genre: genre, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    genre = Catalogs.get_genre!(id)
    {:ok, _genre} = Catalogs.delete_genre(genre)

    conn
    |> put_flash(:info, "Genre deleted successfully.")
    |> redirect(to: Routes.genre_path(conn, :index))
  end
end
