class PaymentType < ApplicationRecord
  has_and_belongs_to_many :establishments

  has_paper_trail(
    :class_name => "PrivateVersion",
    :meta => {
      :actor_id => :actor_id
    },
    :versions => :private_versions
  )

  validates_presence_of :name
  validates_uniqueness_of :name
end
