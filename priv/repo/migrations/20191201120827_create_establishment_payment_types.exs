defmodule Poutineer.Database.Repo.Migrations.CreateEstablishmentPaymentTypes do
  use Ecto.Migration

  def change do
    create table(:establishment_payment_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :establishment_id, references(:establishments, on_delete: :nothing, type: :binary_id), null: false
      add :payment_type_id, references(:payment_types, on_delete: :nothing, type: :binary_id), null: false
    end

    create unique_index(:establishment_payment_types, [:establishment_id, :payment_type_id])
    create index(:establishment_payment_types, [:payment_type_id])
  end
end
