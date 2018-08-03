require("rails_helper")

RSpec.describe("billing-informations") do
  include_context("JSON:API request")

  describe("POST /v1/billing-informations") do
    let(:path) {"/v1/billing-informations"}
    let(:type) {"billing-informations"}
    let(:attributes) do
      {
        :name => "Kurtis Rainbolt-Greene",
        :address => "2985 San Marino St.,\nAPT 11",
        :city => "Los Angeles",
        :state => "CA",
        :postal => "90006"
      }
    end
    let(:relationships) do
      {
        "carts" => [
          relationship(:id => cart.id, :type => "carts")
        ]
      }
    end

    context("with a unfinished cart and a signed-in account") do
      let(:account) {create(:account, :confirmed, :completed)}

      let(:cart) {create(:cart, checkout_state: :needs_delivery_information, account: account)}
      let(:authentication) {account.authentication_secret}

      it("returns CREATED") do
        jsonapi_create

        expect(response).to(have_http_status(:created))
      end

      it("contains a billing-items") do
        jsonapi_create

        expect(response).to(have_jsonapi_type("billing-informations"))
      end

      it("contains a related account") do
        jsonapi_create

        expect(response).to(have_jsonapi_related("account", "id" => account.id, "type" => "accounts"))
      end

      it("contains a related carts") do
        jsonapi_create

        expect(response).to(have_jsonapi_related("carts", ["id" => cart.id, "type" => "carts"]))
      end
    end
  end
end
