class Answer < ApplicationRecord
  belongs_to(:question, :touch => true)
  has_many(:critiques, :dependent => :destroy)

  validates_presence_of(:body)
end
