class AccountRoleStateTransition < ApplicationRecord
  belongs_to :account

  validates_presence_of :event
  validates_presence_of :from
  validates_presence_of :to
end
