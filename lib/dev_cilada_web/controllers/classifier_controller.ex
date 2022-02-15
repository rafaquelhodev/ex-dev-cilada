defmodule DevCiladaWeb.ClassifierController do
  use DevCiladaWeb, :controller

  import DevCilada.UseCases.Classifier
  import DevCilada.UseCases.JobProposal
  import DevCilada.Adapters.AdapterClassifier
  import DevCilada.Adapters.AdapterPerk

  action_fallback DevCiladaWeb.FallbackController

  def show(conn, params) do
    with {:ok, classifier} <- get_classifier_by_id(params["id"]) do
      classifier = adapt_classifier_to_view(classifier)

      perks = adapt_perks_to_view(classifier.perks)

      classifier = Map.put(classifier, :perks, perks)

      render(conn, "show.json", classifier: classifier)
    end
  end

  def create(conn, %{"classifier" => classifier}) do
    classifier =
      with {:ok, classifier} <- create_classifier(classifier),
           do: adapt_classifier_to_view(classifier)

    perks = adapt_perks_to_view(classifier.perks)

    classifier = Map.put(classifier, :perks, perks)

    render(conn, "show.json", classifier: classifier)
  end

  def classsify(conn, %{"job_proposal" => job_proposal}) do
    render(conn, "show.json",
      is_cilada: classify(job_proposal["classifier"], job_proposal["perks"])
    )
  end
end
