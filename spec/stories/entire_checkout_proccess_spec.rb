require "rails_helper"

RSpec.describe "Entire checkout process", type: :request do
  include_context "JSON:API requests"

  let(:email) { "kurtis@rainbolt-greene.online" }

  def transition_cart(event)
    jsonapi_update(
      path: "/v1/carts/mine",
      id: "mine",
      type: "carts",
      attributes: {
        checkout_state_event: event
      }
    )
  end

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

  def associate_shipping_information_to_cart
    jsonapi_update(
      path: "/v1/carts/mine",
      id: "mine",
      type: "carts",
      relationships: {
        "shipping-information" => relationship(id: @shipping_information_id, type: "shipping-informations")
      }
    )
  end

  def associate_billing_information_to_cart
    jsonapi_update(
      path: "/v1/carts/mine",
      id: "mine",
      type: "carts",
      relationships: {
        "billing-information" => relationship(id: @billing_information_id, type: "billing-informations")
      }
    )
  end

  def make_payment
    jsonapi_create(
      path: "/v1/payments",
      type: "payments",
      attributes: {
        "subtype" => "StripePayment",
        "source-id" => "tok_visa"
      }
    )
  end

  before do
    @products = {}
    create_product("a")
    create_product("b")
  end

  it "works" do
    add_product_to_cart("a")
    expect(response).to have_http_status(:created)

    add_product_to_cart("a")
    expect(response).to have_http_status(:created)

    add_product_to_cart("b")
    expect(response).to have_http_status(:created)

    provide_email_address
    expect(response).to have_http_status(:ok)

    enter_shipping_information
    expect(response).to have_http_status(:created)

    @shipping_information_id = json_data.fetch("id")

    associate_shipping_information_to_cart
    expect(response).to have_http_status(:ok)

    transition_cart("ready_for_billing")
    expect(response).to have_http_status(:ok)

    enter_billing_information
    expect(response).to have_http_status(:created)

    @billing_information_id = json_data.fetch("id")

    associate_billing_information_to_cart
    expect(response).to have_http_status(:ok)

    transition_cart("ready_for_payments")
    expect(response).to have_http_status(:ok)

    make_payment
    binding.pry
    expect(response).to have_http_status(:created)

    expect(Cart.count).to be(1)

    expect(CartItem.count).to be(3)

    expect(Cart.last).to have_attributes(checkout_state: "completed")
  end
end
