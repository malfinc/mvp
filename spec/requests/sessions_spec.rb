require("rails_helper")

RSpec.describe("sessions", :type => :request) do
  include_context("JSON:API request")

  describe("POST /v1/sessions") do
    let(:path) {"/v1/sessions"}
    let(:data_type) {"sessions"}

    context("when the account exists and the right credentials") do
      let(:account) {create(:account, :confirmed, :completed)}
      let(:data_attributes) do
        {
          :email => account.email,
          :password => account.password
        }
      end

      it("returns status CREATED") do
        jsonapi_create

        expect(response).to(have_http_status(:created))
      end

      it("contains an accounts resource") do
        jsonapi_create

        expect(response).to(have_jsonapi_type("accounts"))
      end

      it("updates the cookies with a session key") do
        expect {jsonapi_create}.to(change {response&.cookies&.to_h}.from(nil).to(hash_including("_poutineer_session" => a_kind_of(String))))
      end
    end
  end
end
