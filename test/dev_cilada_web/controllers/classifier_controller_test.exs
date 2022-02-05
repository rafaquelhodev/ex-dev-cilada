defmodule DevCiladaWeb.ClassifierControllerTest do
  use DevCiladaWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show" do
    test "show given classifier", %{conn: conn} do
      conn = get(conn, Routes.classifier_path(conn, :show, "hash_classifier"))

      assert json_response(conn, 200)["data"] == %{
               "hash" => "hash_classifier",
               "cilada_threshold" => 10
             }
    end
  end

  describe "create" do
    test "create classifier", %{conn: conn} do
      classifier = %{"classifier" => %{"cilada_threshold" => 15}}

      conn = post(conn, Routes.classifier_path(conn, :create, classifier))

      assert json_response(conn, 200)["data"] == %{
               "hash" => 1234,
               "cilada_threshold" => "15"
             }
    end
  end

  describe "classsify" do
    test "classify job proposal", %{conn: conn} do
      job_proposal = %{
        "job_proposal" => %{"perks" => ["123", "456"], "classifier" => "hash_classifier"}
      }

      conn = post(conn, Routes.classifier_path(conn, :classsify, job_proposal))

      assert json_response(conn, 200)["data"] == %{
               "perks" => ["123", "456"],
               "is_cilada" => true
             }
    end
  end
end
