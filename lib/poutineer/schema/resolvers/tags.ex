defmodule Poutineer.Schema.Resolvers.Tags do
  alias Poutineer.Repo
  alias Poutineer.Models.Tag
  import Ecto.Query, only: [from: 2]

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Tag)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Tag, arguments[:id])}
  end

  def create(_parent, arguments, _resolution) do
    %{name: name, subject_id: subject_id} = arguments

    # Create a new tag or failing that find a tag by that name
    tag = Repo.insert(Tag.changeset(%Tag{}, %{name: name}))
      |> case do
        {:ok, tag} -> tag
        {:error, _} -> Repo.one(from(tag in Tag, where: tag.name == ^name))
      end

    # Figure out the model we're trying to attach a tag to
    subject_model = case arguments do
      %{subject_type: :establishment} -> Poutineer.Models.Establishment
      %{subject_type: :review} -> Poutineer.Models.Review
      %{subject_type: :recipe} -> Poutineer.Models.Recipe
      %{subject_type: :menu_item} -> Poutineer.Models.MenuItem
    end

    # Go find that record, and then preload tags
    subject = Repo.get!(subject_model, subject_id) |> Repo.preload(:tags)

    if subject do
      subject
        |> Ecto.Changeset.change()
        # Prepend the tag to the list of tags, let ecto handle the difference
        |> Ecto.Changeset.put_assoc(:tags, [tag | subject.tags])
        |> Repo.update()
        # If it worked, returned the tag, otherwise return the error
        |> case do
          {:ok, _} -> {:ok, tag}
          {:error, _} = error -> error
        end
    end
  end
end
