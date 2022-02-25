defmodule DevCilada.Adapters.AdapterPerk do
  @attributes [:id, :cilada_points, :description]

  def adapt_perks_to_view(perks) do
    Enum.map(perks, fn p -> adapt_perk_to_view(p) end)
  end

  def adapt_perk_to_view(perk) do
    Map.take(perk, @attributes)
  end
end
