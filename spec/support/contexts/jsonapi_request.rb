RSpec.shared_context("JSON:API request") do
  let(:default_headers) do
    {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => if try(:payload).present? then "application/vnd.api+json" end,
      "Authentication" => if try(:authentication).present? then "Bearer #{Base64.urlsafe_encode64(authentication)}" end
    }.compact
  end

  def jsonapi_create
    post(
      path,
      :headers => default_headers.merge(try(:custom_headers) || {}),
      :params => payload
    )
  end

  def payload
    Oj.dump(
      {
        :data => {
          :type => type.to_s,
          :attributes => if try(:attributes).present? then attributes.compact end,
          :relationships => if try(:relationships).present? then relationships.compact end
        }.compact,
        :metadata => if try(:metadata).present? then metadata.compact end,
        :included => if try(:included).present? then included.compact end
      }.compact.deep_stringify_keys
    )
  end

  def relationship(id:, type:)
    {
      :data => {
        :id => id,
        :type => type
      }
    }
  end

  def json
    Oj.load(response.body)
  end

  def json_data
    json.fetch("data")
  end

  def json_data_attributes
    json_data.fetch("attributes")
  end
end
