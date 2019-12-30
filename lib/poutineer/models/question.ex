defmodule Poutineer.Models.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :body, :string
    field :kind, :string
    has_many :critiques, Poutineer.Models.Critique
    has_many :answers, Poutineer.Models.Answer
    belongs_to :requisit_answer, Poutineer.Models.Answer, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Question{} = question, attributes \\ %{}) do
    question
      |> cast(attributes, [:body, :kind])
      |> cast_assoc(:answers, with: &Poutineer.Models.Answer.changeset/2)
      |> cast_assoc(:requisit_answer, with: &Poutineer.Models.Answer.changeset/2)
      |> validate_required([:body, :kind])
  end
end
