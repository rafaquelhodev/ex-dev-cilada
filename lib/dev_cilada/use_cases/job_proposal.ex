defmodule DevCilada.UseCases.JobProposal do
  alias DevCilada.JobProposal

  @doc """
  Classifies whether a job proposal is a cilada.
  """
  @spec classify(binary(), list(binary())) :: boolean()
  def classify(classifier_id, perks_id) do
    JobProposal.classify(classifier_id, perks_id)
  end
end
