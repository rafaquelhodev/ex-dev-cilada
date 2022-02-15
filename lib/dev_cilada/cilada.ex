defmodule DevCilada.Cilada do
  @moduledoc """
  The Cilada context.
  """

  import Ecto.Query, only: [from: 2], warn: false

  alias DevCilada.Repo

  alias DevCilada.Cilada.Classifier

  alias DevCilada.Cilada.Perk

  @doc """
  Returns the list of classifiers.

  ## Examples

      iex> list_classifiers()
      [%Classifier{}, ...]

  """
  def list_classifiers do
    Repo.all(Classifier)
  end

  @doc """
  Gets a single classifier.

  Raises `Ecto.NoResultsError` if the Classifier does not exist.

  ## Examples

      iex> get_classifier!(123)
      %Classifier{}

      iex> get_classifier!(456)
      ** (Ecto.NoResultsError)

  """
  def get_classifier!(id), do: Repo.get!(Classifier, id)

  @doc """
  Gets a single classifier.

  Return `{:ok, classifier}` in case of sucess. In case of not finding, returns `{:error, :not_found}`
  """
  @spec get_classifier(binary()) :: {:error, :not_found} | {:ok, %Classifier{}}
  def get_classifier(id) do
    case Repo.get(Classifier, id) do
      nil -> {:error, :not_found}
      classifier -> {:ok, classifier}
    end
  end

  @spec get_classifier_with_perks(binary()) :: {:error, :not_found} | {:ok, %Classifier{}}
  def get_classifier_with_perks(id) do
    case get_classifier(id) do
      {:error, reason} -> {:error, reason}
      {:ok, classifier} -> {:ok, Repo.preload(classifier, :perks)}
    end
  end

  @doc """
  Returns perks from a classifier from a list of perks.
  """
  @spec get_perks_from_classifier(String.t(), list(String.t())) :: list(%Perk{})
  def get_perks_from_classifier(classifier_id, perk_ids) do
    query =
      from p in Perk,
        where: p.classifier_id == ^classifier_id and p.id in ^perk_ids,
        select: p

    Repo.all(query)
  end

  # A function head declaring defaults
  def create_classifier(attrs \\ %{})

  @doc """
  Creates a classifier.

  ## Examples

      iex> create_classifier(%{field: value})
      {:ok, %Classifier{}}

      iex> create_classifier(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_classifier(attrs) do
    %Classifier{}
    |> Classifier.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a classifier with associated perks.
  """
  def create_classifier(classifier, perks) do
    Repo.transaction(fn ->
      classifier = Classifier.changeset(%Classifier{}, classifier)

      perks =
        Enum.map(perks, fn perk ->
          Perk.changeset(%Perk{}, Map.put(perk, "classifier", classifier))
        end)

      classifier_with_perks = Ecto.Changeset.put_assoc(classifier, :perks, perks)
      Repo.insert!(classifier_with_perks)
    end)
  end

  @doc """
  Updates a classifier.

  ## Examples

      iex> update_classifier(classifier, %{field: new_value})
      {:ok, %Classifier{}}

      iex> update_classifier(classifier, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_classifier(%Classifier{} = classifier, attrs) do
    classifier
    |> Classifier.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a classifier.

  ## Examples

      iex> delete_classifier(classifier)
      {:ok, %Classifier{}}

      iex> delete_classifier(classifier)
      {:error, %Ecto.Changeset{}}

  """
  def delete_classifier(%Classifier{} = classifier) do
    Repo.delete(classifier)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking classifier changes.

  ## Examples

      iex> change_classifier(classifier)
      %Ecto.Changeset{data: %Classifier{}}

  """
  def change_classifier(%Classifier{} = classifier, attrs \\ %{}) do
    Classifier.changeset(classifier, attrs)
  end

  @doc """
  Returns the list of perks.

  ## Examples

      iex> list_perks()
      [%Perk{}, ...]

  """
  def list_perks do
    Repo.all(Perk)
  end

  @doc """
  Gets a single perk.

  Raises `Ecto.NoResultsError` if the Perk does not exist.

  ## Examples

      iex> get_perk!(123)
      %Perk{}

      iex> get_perk!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perk!(id), do: Repo.get!(Perk, id)

  @doc """
  Creates a perk.

  ## Examples

      iex> create_perk(%{field: value})
      {:ok, %Perk{}}

      iex> create_perk(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perk(attrs \\ %{}) do
    %Perk{}
    |> Perk.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perk.

  ## Examples

      iex> update_perk(perk, %{field: new_value})
      {:ok, %Perk{}}

      iex> update_perk(perk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perk(%Perk{} = perk, attrs) do
    perk
    |> Perk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a perk.

  ## Examples

      iex> delete_perk(perk)
      {:ok, %Perk{}}

      iex> delete_perk(perk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perk(%Perk{} = perk) do
    Repo.delete(perk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perk changes.

  ## Examples

      iex> change_perk(perk)
      %Ecto.Changeset{data: %Perk{}}

  """
  def change_perk(%Perk{} = perk, attrs \\ %{}) do
    Perk.changeset(perk, attrs)
  end
end
