defmodule DevCilada.CiladaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DevCilada.Cilada` context.
  """

  @doc """
  Generate a classifier.
  """
  def classifier_fixture(attrs \\ %{}) do
    {:ok, classifier} =
      attrs
      |> Enum.into(%{
        cilada_threshold: 42
      })
      |> DevCilada.Cilada.create_classifier()

    classifier
  end

  @doc """
  Generate a perk.
  """
  def perk_fixture(attrs \\ %{}) do
    classifier = classifier_fixture()

    {:ok, perk} =
      attrs
      |> Enum.into(%{
        cilada_points: 42,
        description: "some description",
        classifier_id: classifier.id
      })
      |> DevCilada.Cilada.create_perk()

    perk
  end
end
