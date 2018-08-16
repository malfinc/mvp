module V1
  class PaymentTypeSerializer < ApplicationSerializer
    has_many(:establishments, :if => policy_allows_relation?(:establishments), &policy_scoped(:establishments))
    attribute(:name, :if => policy_allows_attribute?(:name))
  end
end
