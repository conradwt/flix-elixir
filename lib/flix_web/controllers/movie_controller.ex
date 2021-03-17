defmodule FlixWeb.MovieController do
  use FlixWeb, :controller

  alias Flix.Catalogs
  alias Flix.Catalogs.Movie

  def index(conn, _params) do
    movies = Catalogs.list_movies()
    render(conn, "index.html", movies: movies)
  end

  def new(conn, _params) do
    changeset = Catalogs.change_movie(%Movie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"movie" => movie_params}) do
    case Catalogs.create_movie(movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie created successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    movie = Catalogs.get_movie!(id)
    render(conn, "show.html", movie: movie)
  end

  def edit(conn, %{"id" => id}) do
    movie = Catalogs.get_movie!(id)
    changeset = Catalogs.change_movie(movie)
    render(conn, "edit.html", movie: movie, changeset: changeset)
  end

  def update(conn, %{"id" => id, "movie" => movie_params}) do
    movie = Catalogs.get_movie!(id)

    case Catalogs.update_movie(movie, movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie updated successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", movie: movie, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Catalogs.get_movie!(id)
    {:ok, _movie} = Catalogs.delete_movie(movie)

    conn
    |> put_flash(:info, "Movie deleted successfully.")
    |> redirect(to: Routes.movie_path(conn, :index))
  end

  ## WIP
  def movies_filter do
    params = %{filter: "recent"}

    if Enum.member?(["upcoming", "recent", "hits", "flops"], params[:filter]) do
      apply(Movie, params[:filter], [])
    else
      apply(Movie, :released, [])
    end
  end
end
