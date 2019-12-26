defmodule Poutineer.Models.RecipeTag do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipes_tags" do
    belongs_to :recipe, Poutineer.Models.Recipe, primary_key: true
    belongs_to :tag, Poutineer.Models.Tag, primary_key: true
  end
end
