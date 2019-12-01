defmodule Poutineer.Models.Review do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reviews" do
    field :body, :string
    field :moderation_state, :string
    field :author_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:body, :moderation_state])
    |> validate_required([:body, :moderation_state])
  end
end
