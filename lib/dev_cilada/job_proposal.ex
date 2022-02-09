defmodule DevCilada.JobProposal do
  alias DevCilada.Cilada
  alias DevCilada.Cilada.Perk

  @doc """
  Classifies whether a job proposal is a cilada.
  """
  @spec classify(binary(), list(binary())) :: boolean()
  def classify(classifier_id, perks_id) do
    perks = Cilada.get_perks_from_classifier(classifier_id, perks_id)

    Enum.at(perks, 0)
    |> Map.get(:classifier_id)
    |> Cilada.get_classifier!()
    |> Map.get(:cilada_threshold)
    |> is_cilada?(perks)
  end

  @doc """
  Informs if a list of `job_perks` is a cilada.

  ## Examples
      iex> DevCilada.JobProposal.is_cilada?(10, [%Perk{cilada_points: 11}])
      true

      iex> DevCilada.JobProposal.is_cilada?(10, [%Perk{cilada_points: 11}, %Perk{cilada_points: 10}])
      true

      iex> DevCilada.JobProposal.is_cilada?(10, [%Perk{cilada_points: 5}, %Perk{cilada_points: 3}])
      false

  """
  @spec is_cilada?(integer(), list(%Perk{})) :: boolean()
  def is_cilada?(cilada_threshold, job_perks) do
    total_points = Enum.reduce(job_perks, 0, fn x, acc -> acc + x.cilada_points end)
    total_points > cilada_threshold
  end
end
