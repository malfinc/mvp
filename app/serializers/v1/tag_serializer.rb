module V1
  class TagSerializer < ApplicationSerializer
    attribute(:name, :if => policy_allows_attribute?(:name))
  end
end
