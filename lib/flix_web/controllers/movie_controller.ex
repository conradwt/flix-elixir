defmodule FlixWeb.MovieController do
  use FlixWeb, :controller

  import Ecto.Query, only: [from: 2]
  import FlixWeb.UserAuth, only: [require_authenticated_user: 2]

  plug(:require_authenticated_user when action not in [:index, :show])
  plug :require_admin when action not in [:index, :show]

  alias Flix.Catalogs
  alias Flix.Catalogs.{Favorite, Movie}
  alias Flix.Repo

  def index(conn, %{"filter" => filter}) do
    movies = Catalogs.list_movies(filter)
    render(conn, "index.html", movies: movies)
  end

  def index(conn, _params) do
    movies = Catalogs.list_movies()
    render(conn, "index.html", movies: movies)
  end

  def new(conn, _params) do
    changeset = Catalogs.change_movie(%Movie{})

    genres = Catalogs.list_genres()

    render(conn, "new.html", changeset: changeset, genres: genres)
  end

  def create(conn, %{"movie" => movie_params}) do
    case Catalogs.create_movie(movie_params) do
      {:ok, %{movie_info: movie_info, movie_poster: _movie_poster}} ->
        conn
        |> put_flash(:notice, "Movie created successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie_info))

      {:error, :movie_info, changeset, _changes_so_far} ->
        conn
        |> put_flash(:error, "There was a problem creating the movie.  Please try again.")
        |> render("new.html",
          changeset: changeset,
          genres: Catalogs.list_genres()
        )

      {:error, :movie_poster, changeset, _changes_so_far} ->
        conn
        |> put_flash(:error, "There was a problem creating the movie.  Please try again.")
        |> render("new.html",
          changeset: changeset,
          genres: Catalogs.list_genres()
        )
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user

    movie =
      Catalogs.get_movie!(id)
      |> Repo.preload([:fans, :genres, :reviews])

    favorite =
      if current_user do
        get_user_favorite(movie, current_user)
      else
        nil
      end

    changeset =
      if current_user do
        Catalogs.change_favorite(%Favorite{user_id: current_user.id, movie_id: movie.id})
      else
        Catalogs.change_favorite(%Favorite{})
      end

    render(
      conn,
      "show.html",
      movie: movie,
      review_count: length(movie.reviews),
      fans: movie.fans,
      genres: movie.genres,
      favorite: favorite,
      changeset: changeset
    )
  end

  def edit(conn, %{"id" => id}) do
    movie = Catalogs.get_movie!(id)
    changeset = Catalogs.change_movie(movie)

    genres = Catalogs.list_genres()

    render(conn, "edit.html", changeset: changeset, genres: genres, movie: movie)
  end

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "movie" => movie_params}) do
    movie = Catalogs.get_movie!(id)

    case Catalogs.update_movie(movie, movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:notice, "Movie updated successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "There was a problem updating the movie.  Please try again.")
        |> render("edit.html",
          movie: movie,
          changeset: changeset,
          genres: Catalogs.list_genres()
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Catalogs.get_movie!(id)
    {:ok, _movie} = Catalogs.delete_movie(movie)

    conn
    |> put_flash(:notice, "Movie deleted successfully.")
    |> redirect(to: Routes.movie_path(conn, :index))
  end

  defp get_user_favorite(movie, current_user) do
    if current_user do
      from(f in Favorite,
        where:
          ^movie.id == f.movie_id and
            ^current_user.id == f.user_id
      )
      |> Repo.one()
    end
  end

  defp require_admin(conn, _params) do
    if conn.assigns.current_user.admin do
      conn
    else
      conn
      |> put_flash(:error, "Unauthorized access!")
      |> redirect(to: Routes.movie_path(conn, :index))
      |> halt()
    end
  end
end
