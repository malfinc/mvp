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
      :params => if try(:payload).present? then Oj.dump(payload) end
    )
  end

  def jsonapi_fetch
    get(
      path,
      :headers => default_headers.merge(try(:custom_headers) || {}),
      :params => if try(:payload).present? then payload end
    )
  end

  def payload_data
    {
      :id => if try(:data_id).present? then data_id.to_s end,
      :type => if try(:data_type).present? then data_type.to_s end,
      :attributes => if try(:data_attributes).present? then data_attributes.compact end,
      :relationships => if try(:data_relationships).present? then data_relationships.compact end
    }.compact
  end

  def payload
    {
      :data => payload_data.presence,
      :metadata => if try(:payload_metadata).present? then payload_metadata.compact end,
      :included => if try(:payload_included).present? then payload_included.compact end
    }.compact.deep_stringify_keys
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
