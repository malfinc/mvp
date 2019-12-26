defmodule Poutineer.Models.Critique do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "critiques" do
    field :guage, :integer
    belongs_to :author, Poutineer.Models.Account, primary_key: true
    belongs_to :review, Poutineer.Models.Review, primary_key: true
    belongs_to :answer, Poutineer.Models.Answer, primary_key: true
    belongs_to :question, Poutineer.Models.Question, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Critique{} = critique, attributes \\ %{}) do
    critique
      |> cast(attributes, [:guage])
      |> validate_required([:guage])
      |> foreign_key_constraint(:author_id)
      |> foreign_key_constraint(:review_id)
      |> foreign_key_constraint(:answer_id)
      |> foreign_key_constraint(:question_id)
  end
end
