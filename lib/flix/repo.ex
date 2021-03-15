defmodule Flix.Repo do
  use Ecto.Repo,
    otp_app: :flix,
    adapter: Ecto.Adapters.Postgres
end
