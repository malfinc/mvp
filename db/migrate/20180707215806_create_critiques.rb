class CreateCritiques < ActiveRecord::Migration[5.2]
  def change
    create_table(:critiques) do |table|
      table.belongs_to(:author, :null => false, :foreign_key => {:to_table => :accounts})
      table.belongs_to(:review, :null => false, :foreign_key => true)
      table.belongs_to(:question, :null => false, :foreign_key => true)
      table.belongs_to(:answer, :null => false, :foreign_key => true)
      table.integer(:gauge, :null => false)
      table.timestamps

      table.index([:author_id, :question_id, :review_id, :answer_id], :name => "index_critiques_on_all_relationships", :unique => true)
    end
  end
end
