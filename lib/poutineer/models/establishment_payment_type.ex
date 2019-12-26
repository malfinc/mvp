defmodule Poutineer.Models.EstablishmentPaymentType do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "establishment_payment_types" do
    belongs_to :establishment, Poutineer.Models.Establishment
    belongs_to :payment_type, Poutineer.Models.PaymentType
  end
end