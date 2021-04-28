defmodule Flix.Accounts.UserNotifier do
  alias Flix.Email

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    Email.deliver_confirmation_instructions(user, url)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    Email.deliver_reset_password_instructions(user, url)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    Email.deliver_update_email_instructions(user, url)
  end
end
