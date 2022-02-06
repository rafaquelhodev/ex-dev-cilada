defmodule DevCilada.Cilada.Classifier do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "classifiers" do
    field :cilada_threshold, :integer
    has_many :perks, DevCilada.Cilada.Perk

    timestamps()
  end

  @doc false
  def changeset(classifier, attrs) do
    classifier
    |> cast(attrs, [:cilada_threshold])
    |> validate_required([:cilada_threshold])
  end
end
