defmodule DevCiladaWeb.ClassifierView do
  use DevCiladaWeb, :view

  def render("show.json", %{classifier: classifier}) do
    %{data: %{hash: classifier.identifier, cilada_threshold: classifier.cilada_threshold}}
  end
end
