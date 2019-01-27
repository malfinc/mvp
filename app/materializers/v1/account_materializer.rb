module V1
  class AccountMaterializer < ::V1::ApplicationMaterializer
    type(:accounts)

    has(:email, :visible => :readable_attribute?)
    has(:name, :visible => :readable_attribute?)
    has(:username, :visible => :readable_attribute?)
    has(:created_at, :visible => :readable_attribute?)
    has(:updated_at, :visible => :readable_attribute?)

    has_many(:carts, :class_name => "Cart", :visible => :readable_attribute?)
    has_many(:payments, :class_name => "Payment", :visible => :readable_attribute?)
  end
end
