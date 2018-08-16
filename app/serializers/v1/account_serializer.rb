module V1
  class AccountSerializer < ApplicationSerializer
    has_many(:recipes, :if => policy_allows_relation?(:recipes), &policy_scoped(:recipes))
    has_many(:critiques, :if => policy_allows_relation?(:critiques), &policy_scoped(:critiques))
    has_many(:reviews, :if => policy_allows_relation?(:reviews), &policy_scoped(:reviews))

    attribute(:name, :if => policy_allows_attribute?(:name))
    attribute(:username, :if => policy_allows_attribute?(:username))
    attribute(:email, :if => policy_allows_attribute?(:email))
    attribute(:authentication_secret, :if => policy_allows_attribute?(:authentication_secret))
    attribute(:unconfirmed_email, :if => policy_allows_attribute?(:unconfirmed_email))
  end
end
