defmodule Poutineer.Models.MenuItemAllergy do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_item_allergies" do
    belongs_to :allergy, Poutineer.Models.Allergy, primary_key: true
    belongs_to :menu_item, Poutineer.Models.MenuItem, primary_key: true
  end
end
