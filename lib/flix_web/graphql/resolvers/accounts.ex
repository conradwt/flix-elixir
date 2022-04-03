defmodule FlixWeb.GraphQL.Resolvers.Accounts do
  alias Flix.Accounts
  alias FlixWeb.GraphQL.ChangesetErrors

  def signin(_parent, %{email: email, password: password}, _resolution) do
    case Accounts.authenticate(email, password) do
      :error ->
        {:error, "Whoops, invalid credentials!"}

      {:ok, user} ->
        token = Accounts.generate_user_session_token(user)
        {:ok, %{user: user, token: token}}
    end
  end

  def signup(_parent, args, _resolution) do
    case Accounts.register_user(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create account",
          details: ChangesetErrors.error_details(changeset)
        }

      {:ok, user} ->
        token = Accounts.generate_user_session_token(user)
        {:ok, %{user: user, token: token}}
    end
  end

  def me(_parent, _args, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def me(_parent, _args, _resolution) do
    {:ok, nil}
  end
end
