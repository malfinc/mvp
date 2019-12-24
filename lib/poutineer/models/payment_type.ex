defmodule Poutineer.Models.PaymentType do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poutineer.Slugs.Name

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "payment_types" do
    field :name, :string
    field :slug, :string
    many_to_many :establishment, Poutineer.Models.Establishment, join_through: Poutineer.Models.EstablishmentPaymentType

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.PaymentType{} = payment_type, attributes \\ %{}) do
    payment_type
    |> cast(attributes, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> NameSlug.maybe_generate_slug
    |> NameSlug.unique_constraint
  end
end
