defmodule Poutineer.Models.Allergy do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "allergies" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(allergy, attrs) do
    allergy
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
