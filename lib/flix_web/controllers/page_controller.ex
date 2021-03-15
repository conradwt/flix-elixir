defmodule FlixWeb.PageController do
  use FlixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
