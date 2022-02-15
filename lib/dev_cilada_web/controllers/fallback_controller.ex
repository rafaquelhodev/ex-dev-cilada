defmodule DevCiladaWeb.FallbackController do
  use DevCiladaWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(DevCiladaWeb.ClassifierView)
    |> render("error.json", %{error: "entity not found"})
  end
end
