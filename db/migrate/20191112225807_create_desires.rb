class CreateDesires < ActiveRecord::Migration[5.2]
  def change
    create_table(:review_answer_impacts, :id => :uuid) do |t|
      t.belongs_to(:question, :foreign_key => true)
      t.belongs_to(:answer, :foreign_key => true)
      t.belongs_to(:account, :foreign_key => true)
      t.text(:impact, :index => true)
      t.timestamps
      t.index([:answer_id, :account_id, :question_id], unique: true)
    end
  end
end
