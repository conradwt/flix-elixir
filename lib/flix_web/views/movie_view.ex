defmodule FlixWeb.MovieView do
  use FlixWeb, :view

  alias Flix.Catalogs.Movie

  def average_stars_as_percent(movie) do
    average_stars(movie)
  end

  def average_stars(movie) do
    average = movie |> Movie.average_stars()

    if average == 0 do
      "No reviews"
    else
      # number_with_precision(average, precision: 1)
      :erlang.float_to_binary(average, decimals: 1)
    end
  end

  def description(movie) do
    truncate(movie.description, length: 40, separator: " ")
  end

  def main_image(movie) do
    # if movie.main_image.attached?
    #   image_tag movie.main_image.variant(resize_to_limit: [150, nil])
    # else
    #   image_tag 'placeholder.png'
    # end

    # if File.exists?("#{File.cwd!()}/assets/static/images/#{movie.main_image}") do
    #   img_tag("/images/#{movie.main_image}")
    # else
    #   img_tag("/images/placeholder.png")
    # end

    if movie.main_image do
      # Reference:
      #
      # https://aws.amazon.com/premiumsupport/knowledge-center/s3-access-denied-error/
      #
      img_tag(Flix.MainImageUploader.url({movie.main_image, movie}, :thumb, signed: true))
    else
      img_tag(Flix.MainImageUploader.url(nil))
    end
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
