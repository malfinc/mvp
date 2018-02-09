require "rails_helper"

RSpec.describe "shipping-informations" do
  include_context "JSON:API request"

  describe "POST /v1/shipping-informations" do
    let(:path) { "/v1/shipping-informations" }
    let(:type) { "shipping-informations" }
    let(:attributes) do
      {
        name: "Kurtis Rainbolt-Greene",
        address: "2985 San Marino St.,\nAPT 11",
        city: "Los Angeles",
        state: "CA",
        postal: "90006"
      }
    end

    context "with a fresh cart and a signed-in account" do
      let(:account) { Account.create! }
      let(:authentication) {  }

      before do
        product = Product.create!({
          name: "Mona Lisa",
          description: "An incredible painting.",
          price_cents: 100_00,
          price_currency: "USD",
          visibility_state: :visible
        })
        cart = Cart.create!(checkout_state: "fresh", account: account)
        CartItem.create!(product: product, cart: cart, account: account)
      end

      it "returns CREATED" do
        jsonapi_create

        expect(response).to have_http_status(:created)
      end

      it "contains a related account" do
        jsonapi_create

        expect(response).to have_jsonapi_related("account", "id" => account.id, "type" => "accounts")
      end
    end
  end
end
