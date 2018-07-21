class CreateBillingInformationsCarts < ActiveRecord::Migration[5.1]
  def change
    create_join_table(:billing_informations, :carts, :id => :bigserial) do |table|
      table.uuid(:billing_information_id, :null => false, :index => true)
      table.uuid(:cart_id, :null => false, :index => true)
      table.timestamps(:null => false)

      table.index([:billing_information_id, :cart_id], :unique => true, :name => "index_billing_information_carts_on_join_columns")
      table.foreign_key(:billing_informations, :column => :billing_information_id)
      table.foreign_key(:carts, :column => :cart_id)
    end
  end
end
