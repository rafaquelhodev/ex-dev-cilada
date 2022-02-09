defmodule DevCilada.JobProposalTest do
  use DevCilada.DataCase

  alias DevCilada.Cilada.Perk
  doctest DevCilada.JobProposal, import: true

  describe "job proposal" do
    alias DevCilada.Cilada

    alias DevCilada.JobProposal

    test "classify/2 returns cilada true" do
      classifier = %{"cilada_threshold" => 40}
      perk_01 = %{"cilada_points" => 5, "description" => "aqui tem cafézinho"}
      perk_02 = %{"cilada_points" => 15, "description" => "brilho nos olhos"}
      perk_03 = %{"cilada_points" => 30, "description" => "pode vir de bermuda"}

      assert {:ok, classifier} = Cilada.create_classifier(classifier, [perk_01, perk_02, perk_03])

      assert JobProposal.classify(classifier.id, Enum.map(classifier.perks, fn p -> p.id end)) ==
               true
    end

    test "classify/2 returns cilada false" do
      classifier = %{"cilada_threshold" => 40}
      perk_01 = %{"cilada_points" => 5, "description" => "aqui tem cafézinho"}
      perk_02 = %{"cilada_points" => 15, "description" => "brilho nos olhos"}
      perk_03 = %{"cilada_points" => 30, "description" => "pode vir de bermuda"}

      assert {:ok, classifier} = Cilada.create_classifier(classifier, [perk_01, perk_02, perk_03])

      job_perks = Enum.take(classifier.perks, 2) |> Enum.map(fn p -> p.id end)

      assert JobProposal.classify(classifier.id, job_perks) == false
    end
  end
end
