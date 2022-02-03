defmodule DevCiladaWeb.ClassifierController do
  use DevCiladaWeb, :controller

  def show(conn, params) do
    classifier = %{identifier: params["hash"], cilada_threshold: 10}

    render(conn, "show.json", classifier: classifier)
  end

  def create(conn, %{"classifier" => classifier}) do
    classifier = %{identifier: 1234, cilada_threshold: classifier["cilada_threshold"]}

    render(conn, "show.json", classifier: classifier)
  end
end
