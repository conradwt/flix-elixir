defmodule FlixWeb.FanController do
  use FlixWeb, :controller

  alias Flix.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    reviews = user.reviews
    favorite_movies = user.favorite_movies

    render(
      conn,
      "show.html",
      favorite_movies: favorite_movies,
      reviews: reviews,
      user: user
    )
  end
end
