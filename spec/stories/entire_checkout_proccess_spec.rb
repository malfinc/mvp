require "rails_helper"

RSpec.describe "Entire checkout process", type: :request do
  include_context "JSON:API requests"

  let(:email) { "kurtis@rainbolt-greene.online" }

  def create_product(signature)
    @products[signature] = Product.create({
      name: "Mona Lisa ##{SecureRandom.hex()}",
      description: "An incredible painting, with the signature #{SecureRandom.hex()}.",
      price_cents: rand(100..10_000),
      price_currency: "USD",
      visibility_state: :visible
    })
  end

  def add_product_to_cart(signature)
    jsonapi_create(
      path: "/v1/cart-items",
      type: "cart-items",
      relationships: {
        "product" => relationship(id: @products[signature].id, type: "products")
      }
    )
  end

  def provide_email_address
    jsonapi_update(
      path: "/v1/accounts/me",
      id: "me",
      type: "accounts",
      attributes: {
        "email" => email
      }
    )
  end

  def enter_shipping_information
    jsonapi_create(
      path: "/v1/shipping-informations",
      type: "shipping-informations",
      attributes: {
        "name" => "Kurtis Rainbolt-Greene",
        "address" => "2985 San Marino St.\nAPT 11",
        "city" => "Los Angeles",
        "state" => "CA",
        "postal" => "90006"
      }
    )
  end

  def enter_billing_information
    jsonapi_create(
      path: "/v1/billing-informations",
      type: "billing-informations",
      attributes: {
        "name" => "Kurtis Rainbolt-Greene",
        "address" => "2985 San Marino St.\nAPT 11",
        "city" => "Los Angeles",
        "state" => "CA",
        "postal" => "90006"
      }
    )
  end

  def make_payment
    jsonapi_create(
      path: "/v1/payments",
      type: "payments",
      attributes: {
        "subtype" => "StripePayment",
        "service-eid" => "tok_visa"
      }
    )
  end

  before do
    @products = {}
    create_product("a")
    create_product("b")
    add_product_to_cart("a")
    add_product_to_cart("a")
    add_product_to_cart("b")
    provide_email_address
    enter_shipping_information
    enter_billing_information
    binding.pry
    make_payment
  end

  it "creates a cart" do
    expect(Cart.count).to eq(1)
  end

  it "creates two cart items" do
    expect(CartItem.count).to eq(3)
  end

  it "completes the cart" do
    expect(Cart.last).to have_attributes(checkout_state: "completed")
  end
end
