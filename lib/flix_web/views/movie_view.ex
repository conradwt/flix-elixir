defmodule FlixWeb.MovieView do
  use FlixWeb, :view

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

  def main_image(_movie) do
    # if movie.main_image.attached?
    #   image_tag movie.main_image.variant(resize_to_limit: [150, nil])
    # else
    #   image_tag 'placeholder.png'
    # end

    img_tag('placeholder.png')
  end

  def nav_link_to(text, url) do
    # if current_page?(url)
    #   link_to(text, url, class: 'active')
    # else
    #   link_to(text, url)
    # end

    link(text, to: url)
  end

  # def total_gross(movie) do
  #   if movie.flop?
  #     'Flop!'
  #   else
  #     number_to_currency(movie.total_gross, precision: 0)
  #   end
  # end

  # def year_of(movie) do
  #   movie.released_on.year
  # end
end
