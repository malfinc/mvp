class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table(:answers) do |table|
      table.text(:body, :null => false)
      table.belongs_to(:question, :null => false, :foreign_key => true)
      table.timestamps
    end
  end
end
