defmodule DevCilada.Repo.Migrations.CreatePerks do
  use Ecto.Migration

  def change do
    create table(:perks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text
      add :cilada_points, :integer

      timestamps()
    end
  end
end
