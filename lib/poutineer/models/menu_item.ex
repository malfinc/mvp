defmodule Poutineer.Models.MenuItem do
  use Ecto.Schema
  import Estate, only: [machine: 1]
  import Ecto.Changeset

  machine([
    moderation_state: [
      approve: [draft: "published"],
      reject: [draft: "rejected"],
      kill: [published: "killed"],
      archive: [published: "archived"]
    ]
  ])

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_items" do
    field :name, :string
    field :slug, Poutineer.Slugs.Name.Type
    field :body, :string
    field :moderation_state, :string, default: "pending"
    belongs_to :establishment, Poutineer.Models.Establishment, primary_key: true
    has_many :reviews, Poutineer.Models.Review
    many_to_many :tags, Poutineer.Models.Tag, join_through: Poutineer.Models.MenuItemTag, on_replace: :delete
    many_to_many :allergies, Poutineer.Models.Allergy, join_through: Poutineer.Models.MenuItemAllergy, on_replace: :delete
    many_to_many :diets, Poutineer.Models.Diet, join_through: Poutineer.Models.MenuItemDiet, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.MenuItem{} = menu_item, attributes \\ %{}) do
    menu_item
      |> cast(attributes, [:name, :body, :moderation_state])
      |> validate_required([:name, :body, :moderation_state])
      |> Poutineer.Slugs.Name.maybe_generate_slug
      |> Poutineer.Slugs.Name.unique_constraint
      |> foreign_key_constraint(:establishment_id)
  end
end
