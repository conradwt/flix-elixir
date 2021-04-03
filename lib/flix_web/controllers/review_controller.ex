defmodule FlixWeb.ReviewController do
  use FlixWeb, :controller

  import FlixWeb.UserAuth, only: [require_authenticated_user: 2]
  import Ecto.Changeset

  plug(:require_authenticated_user)
  plug(:put_movie)

  alias Flix.Catalogs
  alias Flix.Catalogs.Review

  def index(conn, _params) do
    %{movie: movie} = conn.assigns
    reviews = Catalogs.list_reviews(movie)

    render(conn, "index.html", movie: movie, reviews: reviews)
  end

  def new(conn, _params) do
    %{movie: movie} = conn.assigns
    current_user = conn.assigns.current_user

    changeset =
      movie
      |> Ecto.build_assoc(:reviews, %Review{user_id: current_user.id})
      |> change

    # changeset =
    #   Catalogs.change_review(%Review{
    #     user_id: current_user.id,
    #     movie_id: movie.id
    #   })

    render(conn, "new.html", movie: movie, changeset: changeset)
  end

  def create(conn, %{"review" => review_params}) do
    %{movie: movie} = conn.assigns
    current_user = conn.assigns.current_user

    case Catalogs.create_review(
           review_params
           |> Map.merge(%{"movie_id" => movie.id, "user_id" => current_user.id})
         ) do
      {:ok, _review} ->
        conn
        |> put_flash(:info, "Review created successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", movie: movie, changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   review = Catalogs.get_review!(id)
  #   render(conn, "show.html", review: review)
  # end

  # def edit(conn, %{"id" => id}) do
  #   %{movie: movie} = conn.assigns
  #   current_user = conn.assigns.current_user

  #   review = Catalogs.get_review!(id)
  #   changeset = Catalogs.change_review(review)
  #   render(conn, "edit.html", review: review, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "review" => review_params}) do
  #   %{movie: movie} = conn.assigns
  #   current_user = conn.assigns.current_user

  #   review = Catalogs.get_review!(id)

  #   case Catalogs.update_review(review, review_params) do
  #     {:ok, review} ->
  #       conn
  #       |> put_flash(:info, "Review updated successfully.")
  #       |> redirect(to: Routes.review_path(conn, :show, review))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", review: review, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   review = Catalogs.get_review!(id)
  #   {:ok, _review} = Catalogs.delete_review(review)

  #   conn
  #   |> put_flash(:info, "Review deleted successfully.")
  #   |> redirect(to: Routes.review_path(conn, :index))
  # end

  defp put_movie(conn, _opts) do
    movie = Catalogs.get_movie!(conn.params["movie_id"])

    assign(conn, :movie, movie)
  end
end
