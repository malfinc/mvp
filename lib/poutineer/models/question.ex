defmodule Poutineer.Models.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :body, :string
    field :kind, :string
    has_many :critiques, Poutineer.Models.Critique

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Question{} = question, attributes \\ %{}) do
    question
    |> cast(attributes, [:body, :kind])
    |> validate_required([:body, :kind])
  end
end
