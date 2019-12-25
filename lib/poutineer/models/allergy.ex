defmodule Poutineer.Models.Allergy do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "allergies" do
    field :name, :string
    field :slug, Poutineer.Slugs.Name.Type
    many_to_many :menu_items, Poutineer.Models.MenuItem, join_through: Poutineer.Models.MenuItemAllergy
    many_to_many :recipes, Poutineer.Models.Recipe, join_through: Poutineer.Models.RecipeDiet

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Allergy{} = allergy, attributes \\ %{}) do
    allergy
      |> cast(attributes, [:name])
      |> validate_required([:name])
      |> Poutineer.Slugs.Name.maybe_generate_slug
      |> Poutineer.Slugs.Name.unique_constraint
      |> unique_constraint(:name)
  end
end
