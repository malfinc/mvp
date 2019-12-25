defmodule Poutineer.Models.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :name, :string
    field :slug, Poutineer.Slugs.Name.Type
    many_to_many :menu_items, Poutineer.Models.MenuItem, join_through: Poutineer.Models.MenuItemTag
    many_to_many :reviews, Poutineer.Models.Review, join_through: Poutineer.Models.ReviewTag
    many_to_many :recipes, Poutineer.Models.Recipe, join_through: Poutineer.Models.RecipeTag
    many_to_many :establishments, Poutineer.Models.Establishment, join_through: Poutineer.Models.EstablishmentTag

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
