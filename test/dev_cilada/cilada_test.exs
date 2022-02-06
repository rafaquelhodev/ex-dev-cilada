defmodule DevCilada.CiladaTest do
  use DevCilada.DataCase

  alias DevCilada.Cilada

  describe "classifiers" do
    alias DevCilada.Cilada.Classifier

    import DevCilada.CiladaFixtures

    @invalid_attrs %{cilada_threshold: nil}

    test "list_classifiers/0 returns all classifiers" do
      classifier = classifier_fixture()
      assert Cilada.list_classifiers() == [classifier]
    end

    test "get_classifier!/1 returns the classifier with given id" do
      classifier = classifier_fixture()
      assert Cilada.get_classifier!(classifier.id) == classifier
    end

    test "create_classifier/1 with valid data creates a classifier" do
      valid_attrs = %{cilada_threshold: 42}

      assert {:ok, %Classifier{} = classifier} = Cilada.create_classifier(valid_attrs)
      assert classifier.cilada_threshold == 42
    end

    test "create_classifier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cilada.create_classifier(@invalid_attrs)
    end

    test "update_classifier/2 with valid data updates the classifier" do
      classifier = classifier_fixture()
      update_attrs = %{cilada_threshold: 43}

      assert {:ok, %Classifier{} = classifier} =
               Cilada.update_classifier(classifier, update_attrs)

      assert classifier.cilada_threshold == 43
    end

    test "update_classifier/2 with invalid data returns error changeset" do
      classifier = classifier_fixture()
      assert {:error, %Ecto.Changeset{}} = Cilada.update_classifier(classifier, @invalid_attrs)
      assert classifier == Cilada.get_classifier!(classifier.id)
    end

    test "delete_classifier/1 deletes the classifier" do
      classifier = classifier_fixture()
      assert {:ok, %Classifier{}} = Cilada.delete_classifier(classifier)
      assert_raise Ecto.NoResultsError, fn -> Cilada.get_classifier!(classifier.id) end
    end

    test "change_classifier/1 returns a classifier changeset" do
      classifier = classifier_fixture()
      assert %Ecto.Changeset{} = Cilada.change_classifier(classifier)
    end
  end

  describe "perks" do
    alias DevCilada.Cilada.Perk

    import DevCilada.CiladaFixtures

    @invalid_attrs %{cilada_points: nil, description: nil}

    test "list_perks/0 returns all perks" do
      perk = perk_fixture()
      assert Cilada.list_perks() == [perk]
    end

    test "get_perk!/1 returns the perk with given id" do
      perk = perk_fixture()
      assert Cilada.get_perk!(perk.id) == perk
    end

    test "create_perk/1 with valid data creates a perk" do
      classifier = classifier_fixture()

      valid_attrs = %{
        cilada_points: 42,
        description: "some description",
        classifier_id: classifier.id
      }

      assert {:ok, %Perk{} = perk} = Cilada.create_perk(valid_attrs)
      assert perk.cilada_points == 42
      assert perk.description == "some description"
    end

    test "create_perk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cilada.create_perk(@invalid_attrs)
    end

    test "update_perk/2 with valid data updates the perk" do
      perk = perk_fixture()
      update_attrs = %{cilada_points: 43, description: "some updated description"}

      assert {:ok, %Perk{} = perk} = Cilada.update_perk(perk, update_attrs)
      assert perk.cilada_points == 43
      assert perk.description == "some updated description"
    end

    test "update_perk/2 with invalid data returns error changeset" do
      perk = perk_fixture()
      assert {:error, %Ecto.Changeset{}} = Cilada.update_perk(perk, @invalid_attrs)
      assert perk == Cilada.get_perk!(perk.id)
    end

    test "delete_perk/1 deletes the perk" do
      perk = perk_fixture()
      assert {:ok, %Perk{}} = Cilada.delete_perk(perk)
      assert_raise Ecto.NoResultsError, fn -> Cilada.get_perk!(perk.id) end
    end

    test "change_perk/1 returns a perk changeset" do
      perk = perk_fixture()
      assert %Ecto.Changeset{} = Cilada.change_perk(perk)
    end
  end

  describe "classifiers and perks" do
    alias DevCilada.Cilada.Classifier

    alias DevCilada.Cilada.Perk

    test "create classifier with perks" do
      classifier = %{"cilada_threshold" => 30}

      perk_cafezinho = %{
        "description" => "aqui tem cafezinho",
        "cilada_points" => 30
      }

      perk_vestir_camisa = %{
        "description" => "aqui tem que vestir a camisa",
        "cilada_points" => 10
      }

      assert {:ok, classifier} = Cilada.create_classifier(classifier, [perk_cafezinho, perk_vestir_camisa])

      assert length(classifier.perks) == 2

      perks_received = classifier.perks

      assert_perk(perks_received, classifier, 0)
      assert_perk(perks_received, classifier, 1)
    end

    defp assert_perk(perks, classifier, pos) do
      assert Enum.at(perks, pos).classifier_id == classifier.id
      assert Enum.at(perks, pos).description != nil
      assert Enum.at(perks, pos).cilada_points != nil
    end
  end
end
