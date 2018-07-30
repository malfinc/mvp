class PaymentType < ApplicationRecord
  has_paper_trail(
    :class_name => "BigintVersion",
    :meta => {
      :actor_id => :actor_id
    },
    :versions => :bigint_versions
  )

  validates_presence_of :name
  validates_uniqueness_of :name
end
