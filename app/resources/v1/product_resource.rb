module V1
  class ProductResource < ::V1::ApplicationResource
    has_many :cart_items
  end
end
