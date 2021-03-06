defmodule FlixWeb.UserSessionController do
  use FlixWeb, :controller

  alias Flix.Accounts
  alias FlixWeb.UserAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      conn
      |> put_flash(:notice, "Welcome back, #{user.name}!")
      |> UserAuth.log_in_user(user, user_params)
    else
      render(conn, "new.html", error_message: "Invalid email/password combination!")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:notice, "You're now signed out!")
    |> UserAuth.log_out_user()
  end
end
