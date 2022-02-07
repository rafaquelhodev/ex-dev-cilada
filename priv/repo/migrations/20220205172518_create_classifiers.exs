defmodule DevCilada.Repo.Migrations.CreateClassifiers do
  use Ecto.Migration

  def change do
    create table(:classifiers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :cilada_threshold, :integer

      timestamps()
    end
  end
end
