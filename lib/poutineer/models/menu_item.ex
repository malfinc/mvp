defmodule Poutineer.Models.MenuItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_items" do
    field :body, :string
    field :moderation_state, :string
    field :name, :string
    field :slug, :string
    field :establishment_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(menu_item, attrs) do
    menu_item
    |> cast(attrs, [:name, :slug, :body, :moderation_state])
    |> validate_required([:name, :slug, :body, :moderation_state])
    |> unique_constraint(:slug)
  end
end
