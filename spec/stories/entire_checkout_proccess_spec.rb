require "rails_helper"

RSpec.describe "Entire checkout process", type: :request do
  let(:product_attributes) do
    {
      name: "Mona Lisa",
      description: "An incredible painting.",
      price_cents: 100_00,
      price_currency: "USD",
      visibility_state: :visible
    }
  end
  let(:product) { Product.new(product_attributes) }

  def default_headers(content: nil, authentication: nil)
    {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => if content.present? then "application/vnd.api+json" end,
      "Authorization" => if authentication.present? then "Bearer #{Base64.encode64(authentication)}" end
    }.compact
  end

  def jsonapi_create(location:, type:, authentication: nil, headers: {}, **data)
    post(
      location,
      headers: default_headers(
        content: true,
        authentication: authentication
      ).merge(headers),
      params: payload(type: type, **data)
    )
  end

  def payload(type:, attributes: {}, relationships: [], metadata: {}, included: [])
    Oj.dump({
      data: {
        type: type.to_s,
        attributes: attributes.compact,
        relationships: relationships.compact,
      }.compact,
      metadata: metadata.compact,
      included: included.compact,
    }.compact.deep_stringify_keys)
  end

  def relationship(id:, type:)
    {
      data: {
        id: id,
        type: type.to_s
      }
    }
  end

  def create_a_product
    product.save!
  end

  def add_a_product_to_cart
    jsonapi_create(
      location: "/v1/cart-items",
      type: "cart-items",
      relationships: {
        product: relationship(id: product.id, type: :products)
      }
    )
  end

  def enter_shipping_information
    jsonapi_create(
      location: "/v1/shipping-informations",
      type: "shipping-informations",
      attributes: {
        email: "kurtis@rainbolt-greene.online",
        name: "Kurtis Rainbolt-Greene",
        address: "2985 San Marino St.\nAPT 11",
        city: "Los Angeles",
        state: "CA",
        postal: "90006"
      }
    )
  end

  def enter_billing_information
    jsonapi_create(
      location: "/v1/billing-informations",
      type: "billing-informations",
      attributes: {
        name: "Kurtis Rainbolt-Greene",
        address: "2985 San Marino St.\nAPT 11",
        city: "Los Angeles",
        state: "CA",
        postal: "90006"
      }
    )
  end

  def make_payment
    jsonapi_create(
      location: "/v1/payments",
      type: "payments",
      attributes: {
        type: "StripePayment",
        external_id: "tok_visa"
      }
    )
  end

  before do
    create_a_product
    add_a_product_to_cart
    add_a_product_to_cart
    enter_shipping_information
    enter_billing_information
    make_payment
  end

  it "creates a cart" do
    expect(Cart.count).to eq(1)
  end

  it "creates two cart items" do
    expect(CartItem.count).to eq(2)
  end

  it "completes the cart" do
    expect(Cart.last).to have_attributes(checkout_state: "completed")
  end
end
