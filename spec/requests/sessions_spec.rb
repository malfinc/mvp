require("rails_helper")

RSpec.describe("sessions") do
  include_context("JSON:API request")

  describe("POST /v1/sessions") do
    let(:path) {"/v1/sessions"}
    let(:type) {"sessions"}
    let(:attributes) do
      {
        :email => account.email,
        :password => account.password
      }
    end

    context("with a unfinished cart and a signed-in account") do
      let(:account) {create(:account, :confirmed, :completed)}

      it("returns CREATED") do
        jsonapi_create

        expect(response).to(have_http_status(:created))
      end

      it("contains a accounts") do
        jsonapi_create

        expect(response).to(have_jsonapi_type("accounts"))
      end
    end
  end
end
