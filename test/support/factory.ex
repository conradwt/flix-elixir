defmodule Flix.Support.Factory do
  use ExMachina.Ecto, repo: Flix.Repo

  alias Flix.Accounts
  alias Flix.Accounts.User
  alias Flix.Accounts.UserToken

  def user_factory do
    %{
      name: sequence(:name, &"User #{&1}"),
      email: sequence(:email, &"email#{&1}@example.com"),
      password: "1qaz2wsx3edc",
      username: sequence(:username, &"username#{&1}"),
      admin: false
    }

    # {:ok, user} = Accounts.register_user(params)

    # Ecto.Multi.new()
    # |> Ecto.Multi.update(:user, User.confirm_changeset(user))
    # |> Ecto.Multi.delete_all(:tokens, UserToken.user_and_contexts_query(user, ["confirm"]))

    # user
  end

  # derived factory
  def admin_user_factory do
    struct!(
      user_factory(),
      %{
        admin: true
      }
    )
  end
end
