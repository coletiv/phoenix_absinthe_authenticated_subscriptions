defmodule PhoenixAbsintheAuthenticatedSubscriptions.Accounts do
  @moduledoc false
  import Ecto.Query, warn: false

  alias PhoenixAbsintheAuthenticatedSubscriptions.Repo

  alias PhoenixAbsintheAuthenticatedSubscriptions.Accounts.User

  def authenticate_user(email, password) do
    User
    |> Repo.get_by(email: email)
    |> Bcrypt.check_pass(password)
  end

  def lookup_user(id),
    do: User |> Repo.get_by(id: id)

  def lookup_user_with_company(id) do
    User
    |> Repo.get_by(id: id)
  end

  def lookup_user_by_email(email) do
    User
    |> Repo.get_by(email: email)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(user, attrs \\ %{}) do
    user
    |> User.changeset_update(attrs)
    |> Repo.update()
  end

  def list_users(),
    do: User |> Repo.all()
end
