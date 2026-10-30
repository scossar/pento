defmodule Pento.Repo.Migrations.UpdateUsernameField do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :username, :string
    end
  end
end
