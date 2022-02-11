defmodule DevCiladaWeb.ClassifierView do
  use DevCiladaWeb, :view

  def render("show.json", %{classifier: classifier}) do
    %{
      data: %{
        id: classifier.id,
        cilada_threshold: classifier.cilada_threshold,
        perks: classifier.perks
      }
    }
  end

  def render("show.json", %{job_proposal: job_proposal}) do
    %{data: %{perks: job_proposal.perks, is_cilada: job_proposal.is_cilada}}
  end
end
