defmodule DevCilada.Cilada.Perk do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "perks" do
    field :cilada_points, :integer
    field :description, :string
    belongs_to :classifier, DevCilada.Cilada.Classifier

    timestamps()
  end

  @doc false
  def changeset(perk, attrs) do
    perk
    |> cast(attrs, [:description, :cilada_points])
    |> validate_required([:description, :cilada_points])
  end
end
