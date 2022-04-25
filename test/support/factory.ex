defmodule Flix.Support.Factory do
  use ExMachina.Ecto, repo: Flix.Repo

  alias Flix.Accounts
  alias Flix.Accounts.User
  alias Flix.Accounts.UserToken

  def create_user() do
    int = :erlang.unique_integer([:positive, :monotonic])

    params = %{
      name: "User #{int}",
      email: sequence(:email, &"email#{&1}@example.com"),
      password: "1qaz2wsx3edc",
      password_confirmation: "1qaz2wsx3edc",
      username: sequence(:username, &"username#{&1}")
    }

    {:ok, user} = Accounts.register_user(params)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:user, User.confirm_changeset(user))
    |> Ecto.Multi.delete_all(:tokens, UserToken.user_and_contexts_query(user, ["confirm"]))

    user
  end
end
