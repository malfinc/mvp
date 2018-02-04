class AccountRoleStateTransition < ApplicationRecord
  belongs_to :account

  validates_presence_of :to
end
