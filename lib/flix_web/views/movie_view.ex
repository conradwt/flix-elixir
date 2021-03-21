defmodule FlixWeb.MovieView do
  use FlixWeb, :view

  import Number.Currency
  import Phoenix.HTML.SimplifiedHelpers.Truncate
  import Phoenix.HTML.SimplifiedHelpers.TimeAgoInWords

  alias Flix.Catalogs.Movie

  # def average_stars(movie) do
  #   average = movie.average_stars
  #   average.zero? ? 'No reviews' : number_with_precision(average, precision: 1)
  # end

  # def average_stars_as_percent do
  #   average_stars(self)
  # end

  # def description(movie) do
  #   truncate(movie.description, length: 40, separator: ' ')
  # end

  def main_image(movie) do
    # if movie.main_image.attached?
    #   image_tag movie.main_image.variant(resize_to_limit: [150, nil])
    # else
    #   image_tag 'placeholder.png'
    # end

    img_tag("/images/#{movie.main_image}")
  end

  def nav_link_to(text, url) do
    if current_page?(url) do
      link(text, to: url, class: 'active')
    else
      link(text, to: url)
    end
  end

  def total_gross(movie) do
    if Movie.flop?(movie) do
      "Flop!"
    else
      number_to_currency(movie.total_gross, precision: 0)
    end
  end

  def year_of(movie) do
    movie.released_on.year
  end

  defp current_page?(_url) do
    true
  end
end
