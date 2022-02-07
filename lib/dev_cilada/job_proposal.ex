defmodule DevCilada.JobProposal do
  alias DevCilada.Cilada.Perk

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
