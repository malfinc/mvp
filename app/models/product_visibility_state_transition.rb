class ProductVisibilityStateTransition < ApplicationRecord
  belongs_to :product

  validates_presence_of :event
  validates_presence_of :from
  validates_presence_of :to
end
