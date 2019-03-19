class CreateEstablishmentPaymentTypes < ActiveRecord::Migration[5.2]
  def change
    create_join_table(:establishments, :payment_types) do |table|
      table.belongs_to(:establishment, :foreign_key => true, :null => false)
      table.belongs_to(:payment_type, :foreign_key => true, :null => false)

      table.index([:establishment_id, :payment_type_id], :unique => true, :name => :index_establishments_payment_types_on_join_ids)
    end
  end
end
