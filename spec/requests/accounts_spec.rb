require("rails_helper")

RSpec.describe("accounts", :type => :request) do
  include_context("JSON:API request")

  describe("GET /v1/accounts/{id}") do
    let(:path) {"/v1/accounts/#{account.id}"}

    context("with an account that exists and the actor is requesting itself while logged in") do
      let(:account) {create(:account, :confirmed, :completed)}
      let(:authentication) {account.authentication_secret}

      it("returns status OK") do
        jsonapi_fetch

        expect(response).to(have_http_status(:ok))
      end

      it("contains an accounts resource") do
        jsonapi_fetch

        expect(response).to(have_jsonapi_type("accounts"))
      end

      it("contains the accounts's id") do
        jsonapi_fetch

        expect(response).to(have_jsonapi_id(account.id))
      end
    end
  end
end
