defmodule DevCiladaWeb.FallbackController do
  use DevCiladaWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(DevCiladaWeb.ClassifierView)
    |> render("error.json", %{error: "entity not found"})
  end

  def call(conn, {:error, :query_error}) do
    conn
    |> put_status(:not_found)
    |> put_view(DevCiladaWeb.ClassifierView)
    |> render("error.json", %{error: "query error"})
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(DevCiladaWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
