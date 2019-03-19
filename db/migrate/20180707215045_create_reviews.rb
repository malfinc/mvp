class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table(:reviews) do |table|
      table.belongs_to(:author, :null => false, :foreign_key => {:to_table => :accounts})
      table.text(:body, :null => false)
      table.text(:moderation_state, :null => false)
      table.timestamps

      table.index(:created_at)
      table.index(:moderation_state)
    end
  end
end
