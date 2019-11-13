class Desire < ApplicationRecord
  belongs_to(:question)
  belongs_to(:account)
  belongs_to(:answer)

  enum(:impact => [:low, :medium, :high])
end
