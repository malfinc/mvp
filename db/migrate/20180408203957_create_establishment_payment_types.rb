class CreateEstablishmentPaymentTypes < ActiveRecord::Migration[5.1]
  def change
    create_join_table :establishments, :payment_types do |table|
      table.references(:establishment, :type => :uuid, :index => true, :foreign_key => true, :null => false)
      table.references(:payment_type, :type => :bigint, :index => true, :foreign_key => true, :null => false)

      table.index([:establishment_id, :payment_type_id], :unique => true, :name => :index_establishments_payment_types_on_join_ids)
    end
  end
end
