defmodule Poutineer.Models.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "answers" do
    field :body, :string
    belongs_to :question, Poutineer.Models.Question, primary_key: true
    has_many :critiques, Poutineer.Models.Critique

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Answer{} = answer, attributes \\ %{}) do
    answer
      |> cast(attributes, [:body])
      |> validate_required([:body])
  end
end
