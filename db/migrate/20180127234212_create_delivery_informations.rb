class CreateDeliveryInformations < ActiveRecord::Migration[5.1]
  def change
    create_table(:delivery_informations, :id => :uuid) do |table|
      table.text(:name, :null => false)
      table.text(:address, :null => false)
      table.text(:postal, :null => false)
      table.text(:city, :null => false)
      table.text(:state, :null => false)
      table.uuid(:account_id, :null => false)
      table.timestamps(:null => false)

      table.index(:account_id)
      table.foreign_key(:accounts, :column => :account_id)
    end
  end
end
