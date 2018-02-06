require "rails_helper"

RSpec.describe "cart-items" do
  include_context "JSON:API request"

  describe "POST /v1/cart-items" do
    let(:path) { "/v1/cart-items" }
    let(:type) { "cart-items" }
    let(:relationships) do
      {
        product: {
          data: {
            id: product.id,
            type: "products"
          }
        }
      }
    end

    context "not logged in without a cart for a product that exists" do
      let(:product_attributes) do
        {
          name: "Mona Lisa",
          description: "An incredible painting.",
          price_cents: 100_00,
          price_currency: "USD",
          visibility_state: :visible
        }
      end
      let(:product) { Product.create!(product_attributes) }
      let(:account) { Account.last }

      it "returns CREATED" do
        jsonapi_create

        expect(response).to have_http_status(:created)
      end

      it "sets the guest account id on the session" do
        jsonapi_create

        expect(session).to have_pairing("guest_id", account.id)
      end

      it "contains a cart item" do
        jsonapi_create

        expect(response).to have_jsonapi_type("cart-items")
      end

      it "has the price_cents of the related product" do
        jsonapi_create

        expect(response).to have_jsonapi_attributes("price-cents" => product.price_cents)
      end

      it "has the price_currency of the related product" do
        jsonapi_create

        expect(response).to have_jsonapi_attributes("price-currency" => product.price_currency)
      end

      it "has the price of the related product" do
        jsonapi_create

        expect(response).to have_jsonapi_attributes("price" => product.price.format)
      end

      it "contains a related product" do
        jsonapi_create

        expect(response).to have_jsonapi_related("product", "id" => product.id, "type" => "products")
      end

      it "contains a related account" do
        jsonapi_create

        expect(response).to have_jsonapi_related("account", "id" => account.id, "type" => "accounts")
      end
    end
  end
end
