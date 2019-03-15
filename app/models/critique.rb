class Critique < ApplicationRecord
  belongs_to(:review)
  belongs_to(:question)
  belongs_to(:answer)
  belongs_to(:author, :class_name => "Account")
end
