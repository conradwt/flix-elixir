defmodule FlixWeb.ReviewView do
  use FlixWeb, :view

  alias Flix.Catalogs.Review

  # def render("new.html", assigns) do
  #   "rendering with assigns #{inspect(Map.values(assigns))}"
  # end

  def pluralize(n, word) do
    case n do
      0 -> "0 #{word}s"
      1 -> "1 #{word}"
      n -> "#{n} #{word}s"
    end
  end
end
