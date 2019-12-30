defmodule Poutineer.Models.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "answers" do
    field :body, :string
    belongs_to :question, Poutineer.Models.Question, primary_key: true
    has_many :critiques, Poutineer.Models.Critique
    has_many :questions, Poutineer.Models.Question, foreign_key: :requisit_answer_id


    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Answer{} = answer, attributes \\ %{}) do
    answer
      |> cast(attributes, [:body])
      |> cast_assoc(:questions, with: &Poutineer.Models.Question.changeset/2)
      |> validate_required([:body])
  end
end
