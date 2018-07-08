class Question < ApplicationRecord
  has_many :answers, :dependent => :destroy
  has_many :critiques, :dependent => :destroy

  enum :type => [:pick_one, :pick_many]

  validates_presence_of :body
end
