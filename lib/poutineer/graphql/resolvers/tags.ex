defmodule Poutineer.Graphql.Resolvers.Tags do
  import Ecto.Query, only: [from: 2]

  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Repo.all(Poutineer.Models.Tag)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Repo.get(Poutineer.Models.Tag, id)}
  end

  def create(_parent, %{name: name, subject_id: subject_id, subject_type: subject_type}, _resolution) when is_bitstring(name) and is_bitstring(subject_id) and is_atom(subject_type) do
    # Create a new tag or failing that find a tag by that name
    tag = Poutineer.Repo.insert(Poutineer.Models.Tag.changeset(%Poutineer.Models.Tag{}, %{name: name}))
      |> case do
        {:ok, tag} -> tag
        {:error, _} -> Poutineer.Repo.one(from(tag in Poutineer.Models.Tag, where: tag.name == ^name))
      end

    # Figure out the model we're trying to attach a tag to
    subject_model = case subject_type do
      :establishment -> Poutineer.Models.Establishment
      :review -> Poutineer.Models.Review
      :recipe -> Poutineer.Models.Recipe
      :menu_item -> Poutineer.Models.MenuItem
    end

    # Go find that record, and then preload tags
    subject = Poutineer.Repo.get!(subject_model, subject_id) |> Poutineer.Repo.preload(:tags)

    if subject do
      subject
        |> Ecto.Changeset.change()
        # Prepend the tag to the list of tags, let ecto handle the difference
        |> Ecto.Changeset.put_assoc(:tags, [tag | subject.tags])
        |> Poutineer.Repo.update()
        # If it worked, returned the tag, otherwise return the error
        |> case do
          {:ok, _} -> {:ok, tag}
          {:error, _} = error -> error
        end
    end
  end
end
