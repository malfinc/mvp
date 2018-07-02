class CreateVersions < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      create_view :versions, File.read(Rails.root.join("db", "views", "versions_v01.sql"))
    end
  end
end
