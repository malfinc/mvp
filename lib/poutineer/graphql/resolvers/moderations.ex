defmodule Poutineer.Graphql.Resolvers.Moderations do
  def publish(_parent, %{subject_id: subject_id, subject_type: subject_type}, _resolution) when is_bitstring(subject_id) and is_atom(subject_type) do
    # Go find that record, and then preload tags
    Poutineer.Repo.get!(moderatable_model(subject_type), subject_id)
      |> moderatable_model(subject_type).publish()
  end

  def approve(_parent, %{subject_id: subject_id, subject_type: subject_type}, _resolution) when is_bitstring(subject_id) and is_atom(subject_type) do
    # Go find that record, and then preload tags
    Poutineer.Repo.get!(moderatable_model(subject_type), subject_id)
      |> moderatable_model(subject_type).approve()
  end

  def reject(_parent, %{subject_id: subject_id, subject_type: subject_type}, _resolution) when is_bitstring(subject_id) and is_atom(subject_type) do
    # Go find that record, and then preload tags
    Poutineer.Repo.get!(moderatable_model(subject_type), subject_id)
      |> moderatable_model(subject_type).reject()
  end

  def kill(_parent, %{subject_id: subject_id, subject_type: subject_type}, _resolution) when is_bitstring(subject_id) and is_atom(subject_type) do
    # Go find that record, and then preload tags
    Poutineer.Repo.get!(moderatable_model(subject_type), subject_id)
      |> moderatable_model(subject_type).kill()
  end

  def archive(_parent, %{subject_id: subject_id, subject_type: subject_type}, _resolution) when is_bitstring(subject_id) and is_atom(subject_type) do
    # Go find that record, and then preload tags
    Poutineer.Repo.get!(moderatable_model(subject_type), subject_id)
      |> moderatable_model(subject_type).archive()
  end

  defp moderatable_model(:establishment), do: Poutineer.Models.Establishment
  defp moderatable_model(:menu_item), do: Poutineer.Models.MenuItem
  defp moderatable_model(:review), do: Poutineer.Models.Review
  defp moderatable_model(:recipe), do: Poutineer.Models.Recipe
end
