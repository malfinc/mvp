defmodule Poutineer.Models.RecipeDiet do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipe_diets" do
    belongs_to :recipe, Poutineer.Models.Recipe, primary_key: true
    belongs_to :diet, Poutineer.Models.Diet, primary_key: true
  end
end
