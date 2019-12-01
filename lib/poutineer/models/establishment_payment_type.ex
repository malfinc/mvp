defmodule Poutineer.Models.EstablishmentPaymentType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "establishment_payment_types" do
    field :establishment_id, :binary_id
    field :payment_type_id, :binary_id
  end

  @doc false
  def changeset(establishment_payment_type, attrs) do
    establishment_payment_type
    |> cast(attrs, [])
    |> validate_required([])
  end
end
