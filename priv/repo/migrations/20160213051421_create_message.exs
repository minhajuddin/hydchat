defmodule Hydchat.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :user, :string
      add :text, :text

      timestamps
    end

  end
end
