defmodule DevCilada.UseCases.Classifier do
  alias DevCilada.Repo
  alias DevCilada.Cilada

  def get_classifier_by_id(id) do
    Cilada.get_classifier!(id) |> Repo.preload(:perks)
  end

  def create_classifier(classifier) do
    Cilada.create_classifier(classifier, classifier["perks"])
  end
end
