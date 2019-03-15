class Question < ApplicationRecord
  has_many(:answers, :dependent => :destroy)
  has_many(:critiques, :dependent => :destroy)

  enum(:kind => [:pick_one, :pick_many])

  validates_presence_of(:body)
  validates_presence_of(:kind)
end
