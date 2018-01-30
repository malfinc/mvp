class AccountStateTransition < ApplicationRecord
  belongs_to :account

  validates_presence_of :namespace
  validates_presence_of :from
  validates_presence_of :to
end
