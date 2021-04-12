defmodule FlixWeb.FavoriteView do
  use FlixWeb, :view

  def fave_or_unfave_button(conn, movie, favorite) do
    if favorite != nil do
      button(
        "♡ Unfave",
        to: Routes.movie_favorite_path(conn, :delete, movie, favorite),
        method: :delete
      )
    else
      button(
        "♥️ Fave",
        to: Routes.movie_favorite_path(conn, :create, movie)
      )
    end
  end
end
