defmodule DevCilada.Repo.Migrations.PerkBelongsToClassifier do
  use Ecto.Migration

  def change do
    alter table(:perks) do
      add :classifier_id, references(:classifiers, type: :uuid)
    end
  end
end
