module V1
  class ProductSerializer < ApplicationSerializer
    has_many :cart_items, include_data: true
  end
end
