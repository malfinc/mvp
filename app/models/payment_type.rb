class PaymentType < ApplicationRecord
  include(AuditedWithTransitions)

  has_and_belongs_to_many(:establishments)

  validates_presence_of(:name)
  validates_uniqueness_of(:name)
end
