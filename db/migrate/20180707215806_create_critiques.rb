class CreateCritiques < ActiveRecord::Migration[5.1]
  def change
    create_table(:critiques, :id => :bigint) do |table|
      table.uuid(:author_id, :null => false)
      table.uuid(:review_id, :null => false)
      table.bigint(:question_id, :null => false)
      table.bigint(:answer_id, :null => false)
      table.integer(:gauge, :null => false)
      table.timestamps

      table.index(:author_id)
      table.index(:question_id)
      table.index(:review_id)
      table.index(:answer_id)
      table.index([:author_id, :question_id, :review_id, :answer_id], :name => "index_critiques_on_all_relationships", :unique => true)

      table.foreign_key(:reviews, :column => :review_id)
      table.foreign_key(:questions, :column => :question_id)
      table.foreign_key(:accounts, :column => :author_id)
    end
  end
end
