defmodule FlixWeb.MovieController do
  use FlixWeb, :controller

  import Ecto.Query, only: [from: 2]
  import FlixWeb.UserAuth, only: [require_authenticated_user: 2]

  plug(:require_authenticated_user when action not in [:index, :show])
  # before_action :require_admin, except: %i[index show]

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
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie created successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "There was a problem creating the movie.  Please try again.")
        |> render("new.html",
          changeset: changeset
        )
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user
    movie = Catalogs.get_movie!(id) |> Repo.preload([:fans, :genres, :reviews])
    review_count = length(movie.reviews)

    fans = movie.fans
    genres = movie.genres

    # favorite = get_user_favorite(movie, current_user)

    render(
      conn,
      "show.html",
      movie: movie,
      review_count: review_count,
      fans: fans,
      genres: genres
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
        |> put_flash(:info, "Movie updated successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "There was a problem updating the movie.  Please try again.")
        |> render("edit.html",
          movie: movie,
          changeset: changeset
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Catalogs.get_movie!(id)
    {:ok, _movie} = Catalogs.delete_movie(movie)

    conn
    |> put_flash(:info, "Movie deleted successfully.")
    |> redirect(to: Routes.movie_path(conn, :index))
  end

  defp get_user_favorite(movie, current_user) do
    favorite =
      if current_user do
        query =
          from(f in Favorite,
            where:
              ^movie.id == f.movie_id and
                ^current_user.id == f.user_id
          )

        query |> Repo.one()
      end

    favorite =
      if favorite != nil do
        favorite
      else
        Catalogs.change_favorite(%Favorite{user_id: current_user.id, movie_id: movie.id})
      end

    favorite
  end
end
