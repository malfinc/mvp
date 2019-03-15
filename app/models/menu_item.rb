class MenuItem < ApplicationRecord
  include(FriendlyId)
  include(Moderated)

  belongs_to(:establishment)
  has_and_belongs_to_many(:diets)
  has_and_belongs_to_many(:allergies)

  Gutentag::ActiveRecord.(self)

  friendly_id(:name, :use => [:slugged, :history])

  validates_presence_of(:name)
  validates_presence_of(:slug)
end
