require "rails_helper"

RSpec.describe "cart-items" do
  # include_context "JSON:API request"
  # include_context "JSON:API response"

  RSpec::Matchers.define :have_jsonapi_type do |expected|
    match do |actual|
      Oj.load(actual.try(:body) || "{}").fetch("data", {}).fetch("type", nil) == expected
    end

    failure_message do |actual|
      body = actual.try(:body)
      return "response had no body or was not a response: #{actual.inspect}" unless body.present?

      native = Oj.load(response.body)
      return "response was not valid json, it was: #{response.body.inspect}" unless native.present?

      data = native["data"]
      return "the payload didn't have the data attribute or was empty, it was: #{data.inspect}" unless data.present?

      type = data["type"]
      return "data.type property either didn't have a value or didn't exist, it was: #{type.inspect}" unless type.present?

      "expected that the JSON:API response type #{type} would be #{expect}"
    end
  end

  RSpec::Matchers.define :have_jsonapi_attributes do |expected|
    match do |actual|
      values_match?(Oj.load(actual.try(:body) || "{}").fetch("data", {}).fetch("attributes", {}), expected)
    end

    failure_message do |actual|
      body = actual.try(:body)
      return "response had no body or was not a response: #{actual.inspect}" unless body.present?

      native = Oj.load(response.body)
      return "response was not valid json, it was: #{response.body.inspect}" unless native.present?

      data = native["data"]
      return "the payload didn't have the data attribute or was empty, it was: #{data.inspect}" unless data.present?

      attributes = data["attributes"]
      return "data.attributes property either didn't have a value or didn't exist, it was: #{attributes.inspect}" unless attributes.present?

      "expected that the JSON:API response attributes #{attributes.inspect} would match #{expect.inspect}"
    end

    diffable
  end

  RSpec::Matchers.define :have_jsonapi_related do |expected_name, expected_related_data|
    match do |actual|
      values_match?(Oj.load(actual.try(:body) || "{}").fetch("data", {}).fetch("relationships", {}).fetch(expected_name, {}), {data: expected_related_data})
    end

    failure_message do |actual|
      body = actual.try(:body)
      return "response had no body or was not a response: #{actual.inspect}" unless body.present?

      native = Oj.load(response.body)
      return "response was not valid json, it was: #{response.body.inspect}" unless native.present?

      data = native["data"]
      return "the payload didn't have the data attribute or was empty, it was: #{data.inspect}" unless data.present?

      relationships = data["relationships"]
      return "data.relationships property either didn't have a value or didn't exist, it was: #{relationships.inspect}" unless relationships.present?

      related = data[expected_name]
      return "data.relationships.#{expected_name} property either didn't have a value or didn't exist, it was: #{related.inspect}" unless related.present?

      "expected that the JSON:API response relationships #{related.inspect} would match #{{data: expected_related_data}.inspect}"
    end

    diffable
  end

  let(:default_headers) do
    {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => if try(:payload).present? then "application/vnd.api+json" end,
      "Authorization" => if try(:authentication).present? then "Bearer #{Base64.encode64(authentication)}" end
    }.compact
  end

  def jsonapi_create
    post(
      path,
      headers: default_headers.merge(headers || {}),
      params: payload
    )
  end

  def payload
    Oj.dump(
      {
        data: {
          type: type.to_s,
          attributes: if try(:attributes).present? then attributes.compact end,
          relationships: if try(:relationships).present? then relationships.compact end,
        }.compact,
        metadata: if try(:metadata).present? then metadata.compact end,
        included: if try(:included).present? then included.compact end,
      }.compact.deep_stringify_keys
    )
  end

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
