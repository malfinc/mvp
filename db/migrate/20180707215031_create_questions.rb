class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table(:questions) do |table|
      table.text(:body, :null => false)
      table.text(:kind, :null => false)
      table.timestamps
    end
  end
end
