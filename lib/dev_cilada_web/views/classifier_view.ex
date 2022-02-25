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

  def render("show.json", %{is_cilada: is_cilada}) do
    %{data: %{is_cilada: is_cilada}}
  end

  def render("error.json", %{error: reason}) do
    %{error: %{reason: reason}}
  end
end
