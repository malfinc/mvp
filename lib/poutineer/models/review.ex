defmodule Poutineer.Models.Review do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reviews" do
    field :body, :string
    field :moderation_state, :string, default: "pending"
    belongs_to :author_account, Poutineer.Models.Account, primary_key: true
    belongs_to :menu_item, Poutineer.Models.MenuItem, primary_key: true
    many_to_many :tags, Poutineer.Models.Tag, join_through: Poutineer.Models.ReviewTag
    has_many :critiques, Poutineer.Models.Critique

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Review{} = review, attributes \\ %{}) do
    review
      |> cast(attributes, [:body, :moderation_state])
      |> validate_required([:body, :moderation_state])
      |> foreign_key_constraint(:author_account_id)
  end
end
