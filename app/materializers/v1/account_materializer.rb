module V1
  class AccountMaterializer < ::V1::ApplicationMaterializer
    type(:accounts)

    has(:email, :visible => :readable?)
    has(:name, :visible => :readable?)
    has(:username, :visible => :readable?)
    has(:created_at, :visible => :readable?)
    has(:updated_at, :visible => :readable?)

    has_many(:carts, :class_name => "Cart", :visible => :readable?)
    has_many(:payments, :class_name => "Payment", :visible => :readable?)
  end
end
