defmodule Flix.Email do
  use Bamboo.Phoenix, view: FlixWeb.EmailView

  alias Flix.Mailer

  @reply_to "flix.elixir@gmail.com"
  @sent_from "flix.elixir@gmail.com"

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    base_email()
    |> to(user.email)
    |> subject("Flix Elixir Confirmation Instructions")
    |> assign(:user, user)
    |> assign(:url, url)
    |> render("confirmation_instructions.html")
    |> deliver()
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    base_email()
    |> to(user.email)
    |> subject("Flix Elixir Reset Password Instructions")
    |> assign(:user, user)
    |> assign(:url, url)
    |> render("reset_password_instructions.html")
    |> deliver()
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    base_email()
    |> to(user.email)
    |> subject("Flix Elixir Update E-mail Instructions")
    |> assign(:user, user)
    |> assign(:url, url)
    |> render("update_email_instructions.html")
    |> deliver()
  end

  def deliver(%Bamboo.Email{} = email, later \\ false) do
    case later do
      true -> Mailer.deliver_now(email)
      false -> Mailer.deliver_later(email)
    end

    {:ok, %{to: email.to, body: email.html_body}}
  end

  defp base_email() do
    new_email()
    |> from(@sent_from)
    |> put_header("Reply-To", @reply_to)
    |> put_html_layout({FlixWeb.LayoutView, "email.html"})
    |> put_text_layout({FlixWeb.LayoutView, "email.text"})
  end
end
