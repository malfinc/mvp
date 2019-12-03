defmodule Poutineer.Models.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipes" do
    field :body, :string
    field :cook_time, :integer
    field :ingredients, {:array, :string}
    field :instructions, {:array, :string}
    field :moderation_state, :string
    field :name, :string
    field :prep_time, :integer
    field :slug, :string
    field :author_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:moderation_state, :name, :slug, :body, :ingredients, :instructions, :cook_time, :prep_time])
    |> validate_required([:moderation_state, :name, :slug, :body, :ingredients, :instructions, :cook_time, :prep_time])
    |> unique_constraint(:slug)
  end
end
