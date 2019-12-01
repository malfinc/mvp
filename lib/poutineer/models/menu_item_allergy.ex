defmodule Poutineer.Models.MenuItemAllergy do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_item_allergies" do
    field :allergy_id, :binary_id
    field :menu_item_id, :binary_id
  end

  @doc false
  def changeset(menu_item_allergy, attrs) do
    menu_item_allergy
    |> cast(attrs, [])
    |> validate_required([])
  end
end
