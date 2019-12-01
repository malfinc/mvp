defmodule Poutineer.Models.RecipeAllergy do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipe_allergies" do
    field :allergy_id, :binary_id
    field :recipe_id, :binary_id
  end

  @doc false
  def changeset(recipe_allergy, attrs) do
    recipe_allergy
    |> cast(attrs, [])
    |> validate_required([])
  end
end
