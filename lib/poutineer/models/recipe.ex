defmodule Poutineer.Models.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

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
    belongs_to :author, Poutineer.Models.Account
    many_to_many :tags, Poutineer.Models.Tag, join_through: Poutineer.Models.RecipeTag

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Recipe{} = recipe, attributes \\ %{}) do
    recipe
      |> cast(attributes, [:moderation_state, :name, :body, :ingredients, :instructions, :cook_time, :prep_time])
      |> validate_required([:moderation_state, :name, :body, :ingredients, :instructions, :cook_time, :prep_time])
      |> Poutineer.Slugs.Name.maybe_generate_slug
      |> Poutineer.Slugs.Name.unique_constraint
      |> foreign_key_constraint(:author_id)
  end
end
