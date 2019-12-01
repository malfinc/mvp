defmodule Poutineer.Models.Diet do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "diets" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(diet, attrs) do
    diet
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
