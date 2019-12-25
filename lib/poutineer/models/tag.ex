defmodule Poutineer.Models.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poutineer.Slugs.Name

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :name, :string
    field :slug, NameSlug.Type

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Tag{} = tag, attributes \\ %{}) do
    tag
      |> cast(attributes, [:name])
      |> validate_required([:name])
      |> Poutineer.Slugs.Name.maybe_generate_slug
      |> Poutineer.Slugs.Name.unique_constraint
      |> unique_constraint(:name)
  end
end
