defmodule DevCilada.Adapters.AdapterClassifier do
  @attributes [:id, :cilada_threshold, :perks]

  def adapt_classifier_to_view(classifier) do
    Map.take(classifier, @attributes)
  end
end
