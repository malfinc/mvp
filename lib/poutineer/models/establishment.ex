defmodule Poutineer.Models.Establishment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "establishments" do
    field :name, :string
    field :slug, Poutineer.Slugs.Name.Type
    field :google_place_data, :map
    field :google_place_id, :string
    field :moderation_state, :string, default: "pending"
    has_many :menu_items, Poutineer.Models.MenuItem
    many_to_many :payment_types, Poutineer.Models.PaymentType, join_through: Poutineer.Models.EstablishmentPaymentType
    many_to_many :tags, Poutineer.Models.Tag, join_through: Poutineer.Models.EstablishmentTag

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Establishment{} = establishment, attributes \\ %{}) do
    establishment
      |> cast(attributes, [:name, :google_place_id, :google_place_data, :moderation_state])
      |> validate_required([:name, :google_place_id, :google_place_data, :moderation_state])
      |> Poutineer.Slugs.Name.maybe_generate_slug
      |> Poutineer.Slugs.Name.unique_constraint
      |> unique_constraint(:google_place_id)
  end
end
