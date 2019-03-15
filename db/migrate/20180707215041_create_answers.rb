class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table(:answers, :id => :bigint) do |table|
      table.text(:body, :null => false)
      table.bigint(:question_id, :null => false)
      table.timestamps

      table.index(:question_id)

      table.foreign_key(:questions, :column => :question_id)
    end
  end
end
