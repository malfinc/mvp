class Recipe < ApplicationRecord
  include FriendlyId
  include Moderated

  belongs_to :author, class_name: "Account"
  has_and_belongs_to_many :diets
  has_and_belongs_to_many :allergies

  Gutentag::ActiveRecord.call self

  friendly_id :name, :use => [:slugged, :history]

  validates_presence_of :author
  validates_presence_of :slug
  validates_presence_of :ingredients
  validates_length_of :ingredients, minimum: 1
  validates_presence_of :created_at, on: :update
  validates_presence_of :updated_at, on: :update

  private def should_generate_new_friendly_id?
    super || send("#{friendly_id_config.base}_changed?")
  end
end
