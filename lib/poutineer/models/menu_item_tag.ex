defmodule Poutineer.Models.MenuItemTag do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_items_tags" do
    belongs_to :menu_item, Poutineer.Models.MenuItem
    belongs_to :tag, Poutineer.Models.Tag

    timestamps()
  end
end
