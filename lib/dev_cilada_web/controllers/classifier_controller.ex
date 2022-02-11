defmodule DevCiladaWeb.ClassifierController do
  use DevCiladaWeb, :controller

  import DevCilada.UseCases.Classifier
  import DevCilada.Adapters.AdapterClassifier
  import DevCilada.Adapters.AdapterPerk

  def show(conn, params) do
    classifier =
      get_classifier_by_id(params["id"])
      |> adapt_classifier_to_view()

    perks = adapt_perks_to_view(classifier.perks)

    classifier = Map.put(classifier, :perks, perks)

    render(conn, "show.json", classifier: classifier)
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
    job_proposal = %{
      perks: job_proposal["perks"],
      classifier: job_proposal["classifier"],
      is_cilada: true
    }

    render(conn, "show.json", job_proposal: job_proposal)
  end
end
