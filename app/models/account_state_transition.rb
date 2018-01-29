class AccountStateTransition < ApplicationRecord
  belongs_to :account

  validate_presence_of :namespace
  validate_presence_of :from
  validate_presence_of :to
end
