module V1
  class ProductResource < ::V1::ApplicationResource
    has_many :cart_items, always_include_linkage_data: true
  end
end
