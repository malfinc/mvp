defmodule Poutineer.Models.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poutineer.NameSlug

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipes" do
    field :name, :string
    field :slug, NameSlug.Type
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
      |> NameSlug.maybe_generate_slug
      |> NameSlug.unique_constraint
  end
end
