require("rails_helper")

RSpec.describe("Entire checkout process", :type => :request) do
  include_context("JSON:API requests")

  let(:email) {"kurtis@rainbolt-greene.online"}

  def transition_cart(event)
    jsonapi_update(
      :path => "/v1/carts/mine",
      :id => "mine",
      :type => "carts",
      :attributes => {
        :checkout_state_event => event
      }
    )
  end

  def create_product(signature)
    @products[signature] = Product.create(
      :name => "Mona Lisa ##{SecureRandom.hex()}",
      :description => "An incredible painting, with the signature #{SecureRandom.hex()}.",
      :price_cents => rand(100..10_000),
      :price_currency => "USD",
      :visibility_state => :visible
    )
  end

  def add_product_to_cart(signature)
    jsonapi_create(
      :path => "/v1/cart-items",
      :type => "cart-items",
      :relationships => {
        "product" => relationship(:id => @products.fetch(signature).id, :type => "products")
      }
    )
  end

  def sign_up
    jsonapi_create(
      :path => "/v1/accounts",
      :type => "accounts",
      :attributes => {
        "email" => email
      }
    )
  end

  def provide_password()
    jsonapi_update(
      :path => "/v1/accounts/me",
      :id => "me",
      :type => "accounts",
      :attributes => {
        :password => "helloworld"
      }
    )
  end

  def enter_delivery_information
    jsonapi_create(
      :path => "/v1/delivery-informations",
      :type => "delivery-informations",
      :attributes => {
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
      :path => "/v1/billing-informations",
      :type => "billing-informations",
      :attributes => {
        "name" => "Kurtis Rainbolt-Greene",
        "address" => "2985 San Marino St.\nAPT 11",
        "city" => "Los Angeles",
        "state" => "CA",
        "postal" => "90006"
      }
    )
  end

  def associate_delivery_information_to_cart
    jsonapi_update(
      :path => "/v1/carts/mine",
      :id => "mine",
      :type => "carts",
      :relationships => {
        "delivery-information" => relationship(:id => "latest", :type => "delivery-informations")
      }
    )
  end

  def associate_billing_information_to_cart
    jsonapi_update(
      :path => "/v1/carts/mine",
      :id => "mine",
      :type => "carts",
      :relationships => {
        "billing-information" => relationship(:id => "latest", :type => "billing-informations")
      }
    )
  end

  def make_payment
    jsonapi_create(
      :path => "/v1/payments",
      :type => "payments",
      :attributes => {
        "subtype" => "StripePayment",
        "source-id" => "tok_visa"
      }
    )
  end

  def login_with(shared, secret)
    jsonapi_create(
      :path => "/v1/sessions",
      :type => "sessions",
      :attributes => {
        "shared" => shared,
        "secret" => secret
      }
    )
  end

  before do
    @products = {}
    create_product("a")
    create_product("b")
  end

  it("works") do
    sign_up()
    expect(response).to(have_http_status(:created))
    expect(Account.count).to eq(1)
    expect(json_data).to match(
      hash_including(
        "id" => a_kind_of(String),
        "attributes" => hash_including(
          "email" => "kurtis@rainbolt-greene.online"
        )
      )
    )

    add_product_to_cart("a")
    expect(response).to(have_http_status(:created))
    expect(CartItem.count).to eq(1)

    add_product_to_cart("a")
    expect(response).to(have_http_status(:created))
    expect(CartItem.count).to eq(2)

    add_product_to_cart("b")
    expect(response).to(have_http_status(:created))
    expect(CartItem.count).to eq(3)

    provide_password()
    expect(response).to(have_http_status(:ok))

    enter_delivery_information
    expect(response).to(have_http_status(:created))

    associate_delivery_information_to_cart
    expect(response).to(have_http_status(:ok))

    transition_cart("ready_for_billing_information")
    expect(response).to(have_http_status(:ok))

    enter_billing_information
    expect(response).to(have_http_status(:created))

    associate_billing_information_to_cart
    expect(response).to(have_http_status(:ok))

    transition_cart("ready_for_payments")
    expect(response).to(have_http_status(:ok))

    make_payment
    expect(response).to(have_http_status(:created))

    expect(Cart.count).to(eq(1))

    current_cart = Cart.last

    expect(current_cart).to(have_attributes(:checkout_state => "purchased"))

    expect(CartItem.count).to(eq(3))

    current_cart.cart_items.each do |cart_item|
      expect(cart_item).to(have_attributes(:purchase_state => "purchased"))
    end

    current_cart.payments.each do |payment|
      expect(payment).to(have_attributes(:processing_state => "paid"))
    end
  end
end
