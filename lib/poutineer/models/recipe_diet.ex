defmodule Poutineer.Models.RecipeDiet do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipe_diets" do
    field :recipe_id, :binary_id
    field :diet_id, :binary_id
  end

  @doc false
  def changeset(recipe_diet, attrs) do
    recipe_diet
    |> cast(attrs, [])
    |> validate_required([])
  end
end
