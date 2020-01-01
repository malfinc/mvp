defmodule Poutineer.Models.Recipe do
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
  schema "recipes" do
    field :name, :string
    field :slug, Poutineer.Slugs.Name.Type
    field :body, :string
    field :cook_time, :integer
    field :ingredients, {:array, :string}
    field :instructions, {:array, :string}
    field :moderation_state, :string, default: "pending"
    field :prep_time, :integer
    belongs_to :author_account, Poutineer.Models.Account
    many_to_many :tags, Poutineer.Models.Tag, join_through: Poutineer.Models.RecipeTag
    many_to_many :allergies, Poutineer.Models.Allergy, join_through: Poutineer.Models.MenuItemAllergy
    many_to_many :diets, Poutineer.Models.Diet, join_through: Poutineer.Models.MenuItemDiet

    timestamps()
  end

  @doc false
  def changeset(%{} = recipe, attributes \\ %{}) do
    recipe
      |> cast(attributes, [:author_account_id, :moderation_state, :name, :body, :ingredients, :instructions, :cook_time, :prep_time])
      |> validate_required([:author_account_id, :moderation_state, :name, :body, :ingredients, :instructions, :cook_time, :prep_time])
      |> Poutineer.Slugs.Name.maybe_generate_slug
      |> Poutineer.Slugs.Name.unique_constraint
      |> assoc_constraint(:author_account)
      |> foreign_key_constraint(:author_account_id)
  end
end
