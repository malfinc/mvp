defmodule Poutineer.Models.Critique do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "critiques" do
    field :guage, :integer
    field :author_id, :binary_id
    field :review_id, :binary_id
    field :answer_id, :binary_id
    field :question_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(critique, attrs) do
    critique
    |> cast(attrs, [:guage])
    |> validate_required([:guage])
  end
end
