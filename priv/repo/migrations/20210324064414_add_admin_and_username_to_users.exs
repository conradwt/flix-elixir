defmodule Flix.Repo.Migrations.AddAdminAndUsernameToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
      add :admin, :boolean, default: false
    end
  end
end
