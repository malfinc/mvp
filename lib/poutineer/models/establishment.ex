defmodule Poutineer.Models.Establishment do
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
  schema "establishments" do
    field :name, :string
    field :slug, Poutineer.Slugs.Name.Type
    field :google_place_data, :map
    field :google_place_id, :string
    field :moderation_state, :string, default: "pending"
    has_many :menu_items, Poutineer.Models.MenuItem
    many_to_many :payment_types, Poutineer.Models.PaymentType, join_through: Poutineer.Models.EstablishmentPaymentType, on_replace: :delete
    many_to_many :tags, Poutineer.Models.Tag, join_through: Poutineer.Models.EstablishmentTag, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Establishment{} = establishment, attributes \\ %{}) do
    establishment
      |> cast(attributes, [:name, :google_place_id, :google_place_data, :moderation_state])
      |> cast_assoc(:menu_items, with: &Poutineer.Models.MenuItem.changeset/2)
      |> validate_required([:name, :google_place_id, :moderation_state])
      |> Poutineer.Slugs.Name.maybe_generate_slug
      |> Poutineer.Slugs.Name.unique_constraint
      |> unique_constraint(:google_place_id)
  end
end
