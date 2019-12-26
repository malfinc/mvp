defmodule Poutineer.Models.RecipeAllergy do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipe_allergies" do
    belongs_to :allergy, Poutineer.Models.Allergy, primary_key: true
    belongs_to :recipe, Poutineer.Models.Recipe, primary_key: true
  end
end
