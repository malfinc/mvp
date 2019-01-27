module V1
  class CartRealizer < ApplicationRealizer
    type(:Carts, :class_name => "Cart", :adapter => :active_record)

    has(:email)
  end
end
