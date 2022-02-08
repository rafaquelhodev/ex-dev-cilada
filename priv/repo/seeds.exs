# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DevCilada.Repo.insert!(%DevCilada.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias DevCilada.Cilada

classifier = %{"cilada_threshold" => 40}
perk_01 = %{"cilada_points" => 5, "description" => "aqui tem cafézinho"}
perk_02 = %{"cilada_points" => 15, "description" => "brilho nos olhos"}
perk_03 = %{"cilada_points" => 30, "description" => "pode vir de bermuda"}

Cilada.create_classifier(classifier, [perk_01, perk_02])
