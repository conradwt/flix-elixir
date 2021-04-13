defmodule FlixWeb.FanController do
  use FlixWeb, :controller

  alias Flix.Catalogs

  def index(conn, _params) do
    users = Catalogs.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Catalogs.get_user!(id)
    render(conn, "show.html", user: user)
  end
end
