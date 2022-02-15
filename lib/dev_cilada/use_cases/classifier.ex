defmodule DevCilada.UseCases.Classifier do
  alias DevCilada.Cilada.Classifier
  alias DevCilada.Cilada

  @spec get_classifier_by_id(binary()) :: {:error, :not_found} | {:ok, %Classifier{}}
  def get_classifier_by_id(id) do
    Cilada.get_classifier_with_perks(id)
  end

  def create_classifier(classifier) do
    Cilada.create_classifier(classifier, classifier["perks"])
  end
end
