defmodule BananaBank.Repo.Migrations.AddUniqueUserId do
  use Ecto.Migration

  def change do
    create unique_index(:accounts, [:user_id], name: :user_id_index)
  end
end
