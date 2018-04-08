class Recipe < ApplicationRecord
  include Redis::Objects
  include FriendlyId
  include Moderated

  belongs_to :author, class_name: "Author"

  Gutentag::ActiveRecord.call self


  validates_presence_of :author
  validates_presence_of :slug
  validates_presence_of :ingredients
  validates_length_of :ingredients, minimum: 1
  validates_presence_of :created_at, on: :update
  validates_presence_of :updated_at, on: :update

  friendly_id :name, :use => [:slugged, :history]
  private def should_generate_new_friendly_id?
    super || send("#{friendly_id_config.base}_changed?")
  end
end
