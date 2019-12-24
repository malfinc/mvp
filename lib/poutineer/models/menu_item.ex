defmodule Poutineer.Models.MenuItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poutineer.NameSlug

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_items" do
    field :name, :string
    field :slug, NameSlug.Type
    field :body, :string
    field :moderation_state, :string, default: "pending"
    belongs_to :establishment, Poutineer.Models.Establishment
    many_to_many :tags, Poutineer.Models.Tag, join_through: Poutineer.Models.MenuItemTag

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.MenuItem{} = menu_item, attributes \\ %{}) do
    menu_item
    |> cast(attributes, [:name, :body, :moderation_state])
    |> validate_required([:name, :body, :moderation_state])
    |> NameSlug.maybe_generate_slug
    |> NameSlug.unique_constraint
  end
end
