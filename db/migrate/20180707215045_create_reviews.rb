class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table(:reviews, :id => :uuid) do |table|
      table.uuid(:author_id, :null => false)
      table.text(:body, :null => false)
      table.text(:moderation_state, :null => false)
      table.timestamps

      table.index(:author_id)
      table.index(:created_at)
      table.index(:moderation_state)

      table.foreign_key(:accounts, :column => :author_id)
    end
  end
end
