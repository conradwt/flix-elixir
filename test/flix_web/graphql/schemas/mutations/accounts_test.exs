defmodule FlixWeb.GraphQL.Schemas.Mutations.AccountsTest do
  use FlixWeb.ConnCase, async: true

  import Flix.Support.Factory

  alias Flix.Accounts

  describe "new session with valid arguments" do
    test "create session" do
      user_params = build(:user)

      {:ok, user} = Accounts.register_user(user_params)

      operation = """
        mutation Signin($email: String!) {
          signin(
            email: $email,
            password: "1qaz2wsx3edc"
          )
          {
            token
            user {
              id
              email
            }
          }
        }
      """

      response =
        post(
          build_conn(),
          "/api",
          query: operation,
          variables: %{"email" => user.email}
        )

      assert %{
        "data" => %{
          "signin" => %{
            "token" => token,
            "user" => _user_data
          }
        }
      } = json_response(response, 200)

      assert {:ok, %{id: user.id}} == FlixWeb.AuthToken.verify(token)
    end
  end
end
