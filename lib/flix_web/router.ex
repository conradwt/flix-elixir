defmodule FlixWeb.Router do
  use FlixWeb, :router

  import FlixWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    if Mix.env() in [:dev, :test] do
      forward "/graphiql",
              Absinthe.Plug.GraphiQL,
              schema: FlixWeb.Graphql.Schema,
              json_codec: Jason,
              interface: :playground
    end

    forward "/api",
            Absinthe.Plug,
            schema: FlixWeb.Graphql.Schema
  end

  scope "/", FlixWeb do
    pipe_through :browser

    get "/", MovieController, :index

    resources "/genres", GenreController

    get "/movies/filter/:filter", MovieController, :index, as: :filtered_movies

    resources "/movies", MovieController do
      resources "/favorites", FavoriteController, only: [:create, :delete]
      resources "/reviews", ReviewController, except: [:show]
    end

    get "/fans", FanController, :index
    get "/fans/:id", FanController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", FlixWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:flix, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FlixWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", FlixWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", FlixWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
    delete "/users/settings", UserSettingsController, :delete
  end

  scope "/", FlixWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
