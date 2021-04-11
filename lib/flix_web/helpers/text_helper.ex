defmodule FlixWeb.Helpers.TextHelper do
  use Phoenix.HTML

  @doc false
  def pluralize(n, word) do
    case n do
      0 -> "0 #{word}s"
      1 -> "1 #{word}"
      n -> "#{n} #{word}s"
    end
  end
end
