defmodule DevCiladaWeb.ClassifierControllerTest do
  use DevCiladaWeb.ConnCase

  import DevCilada.UseCases.Classifier

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show" do
    test "show given classifier", %{conn: conn} do
      classifier = %{
        "cilada_threshold" => 35,
        "perks" => [
          %{"cilada_points" => 20, "description" => "cafezinho"},
          %{"cilada_points" => 30, "description" => "escorregador"}
        ]
      }

      assert {:ok, created_classifier} = create_classifier(classifier)

      created_classifier =
        Map.get(created_classifier, :id)
        |> get_classifier_by_id()

      conn = get(conn, Routes.classifier_path(conn, :show, Map.get(created_classifier, :id)))

      created_perks =
        Enum.map(created_classifier.perks, fn p ->
          %{"cilada_points" => p.cilada_points, "description" => p.description, "id" => p.id}
        end)

      assert json_response(conn, 200)["data"] == %{
               "id" => created_classifier.id,
               "cilada_threshold" => 35,
               "perks" => created_perks
             }
    end
  end

  describe "create" do
    test "create classifier", %{conn: conn} do
      classifier = %{
        classifier: %{
          cilada_threshold: 15,
          perks: [
            %{cilada_points: 20, description: "cafezinho"},
            %{cilada_points: 30, description: "escorregador"}
          ]
        }
      }

      conn = post(conn, Routes.classifier_path(conn, :create), classifier)

      created_classifier =
        json_response(conn, 200)["data"]
        |> Map.get("id")
        |> get_classifier_by_id()

      created_perks =
        Enum.map(created_classifier.perks, fn p ->
          %{"cilada_points" => p.cilada_points, "description" => p.description, "id" => p.id}
        end)

      assert json_response(conn, 200)["data"] == %{
               "id" => created_classifier.id,
               "cilada_threshold" => 15,
               "perks" => created_perks
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
