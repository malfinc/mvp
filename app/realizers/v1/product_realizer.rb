module V1
  class ProductRealizer
    include JSONAPI::Realizer::Resource

    register :products, class_name: "Product", adapter: :active_record

    has_many :cart_items, as: :cart_items
  end
end
