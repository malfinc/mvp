defmodule Poutineer.Models.Review do
  use Ecto.Schema
  import Estate, only: [machine: 1]
  import Ecto.Changeset

  machine([
    moderation_state: [
      approve: [draft: "published"],
      reject: [draft: "rejected"],
      kill: [published: "killed"],
      archive: [published: "archived"]
    ]
  ])

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reviews" do
    field :body, :string
    field :moderation_state, :string, default: "pending"
    belongs_to :author_account, Poutineer.Models.Account, primary_key: true
    belongs_to :menu_item, Poutineer.Models.MenuItem, primary_key: true
    many_to_many :tags, Poutineer.Models.Tag, join_through: Poutineer.Models.ReviewTag, on_replace: :delete
    has_many :critiques, Poutineer.Models.Critique

    timestamps()
  end

  @doc false
  def changeset(%{} = review, attributes \\ %{}) do
    review
      |> cast(attributes, [:body, :moderation_state])
      |> validate_required([:body, :moderation_state])
      |> foreign_key_constraint(:author_account_id)
  end
end
