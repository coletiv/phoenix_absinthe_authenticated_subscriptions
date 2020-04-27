defmodule PhoenixAbsintheAuthenticatedSubscriptions.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false

      add :password_hash, :string, null: false

      timestamps()
    end

    create_if_not_exists unique_index(:users, :email)
  end
end
