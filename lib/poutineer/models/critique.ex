defmodule Poutineer.Models.Critique do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "critiques" do
    field :guage, :integer
    belongs_to :author, Poutineer.Models.Account
    belongs_to :review, Poutineer.Models.Review
    belongs_to :answer, Poutineer.Models.Answer
    belongs_to :question, Poutineer.Models.Question

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Critique{} = critique, attributes \\ %{}) do
    critique
    |> cast(attributes, [:guage])
    |> validate_required([:guage])
  end
end
