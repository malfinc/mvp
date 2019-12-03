defmodule Poutineer.Models.Establishment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "establishments" do
    field :google_place_data, :map
    field :google_place_id, :string
    field :moderation_state, :string
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(establishment, attrs) do
    establishment
    |> cast(attrs, [:name, :slug, :google_place_id, :google_place_data, :moderation_state])
    |> validate_required([:name, :slug, :google_place_id, :google_place_data, :moderation_state])
    |> unique_constraint(:slug)
    |> unique_constraint(:google_place_id)
  end
end
