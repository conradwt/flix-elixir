defmodule FlixWeb.FavoriteView do
  use FlixWeb, :view

  def fave_or_unfave_button(_movie, _favorite) do
    # if favorite
    #   button_to "♡ Unfave", to: Routes.movie_favorite_path(movie, favorite), method: :delete
    # else
    #   button_to "♥️ Fave", to: Routes.movie_favorites_path(movie)
    # end
  end
end
