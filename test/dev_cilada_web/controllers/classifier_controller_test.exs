defmodule DevCiladaWeb.ClassifierControllerTest do
  use DevCiladaWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show" do
    test "show given classifier", %{conn: conn} do
      conn = get(conn, Routes.classifier_path(conn, :show, "123"))
      assert json_response(conn, 200)["data"] != []
    end
  end
end
