class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions, :id => :bigint do |table|
      table.text(:body, :null => false)
      table.text(:type, :null => false)
      table.timestamps
    end
  end
end
