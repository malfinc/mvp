RSpec.shared_context("JSON:API requests") do
  def default_headers(content: nil, authentication: nil)
    {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => if content.present? then "application/vnd.api+json" end,
      "Authentication" => if authentication.present? then "Bearer #{Base64.urlsafe_encode64(authentication)}" end
    }.compact
  end

  def jsonapi_update(path:, id:, type:, authentication: nil, custom_headers: {}, **data)
    put(
      path,
      :headers => default_headers(:content => true, :authentication => authentication).merge(custom_headers || {}),
      :params => payload(:id => id, :type => type, **data)
    )
  end

  def jsonapi_create(path:, type:, authentication: nil, custom_headers: {}, **data)
    post(
      path,
      :headers => default_headers(:content => true, :authentication => authentication).merge(custom_headers || {}),
      :params => payload(:type => type, **data)
    )
  end

  def payload(id: nil, type:, attributes: nil, relationships: nil, metadata: nil, included: nil)
    JSON.dump(
      {
        :data => {
          :id => id.presence,
          :type => type,
          :attributes => if attributes.present? then attributes.compact end,
          :relationships => if relationships.present? then relationships.compact end
        }.compact,
        :metadata => if metadata.present? then metadata.compact end,
        :included => if included.present? then included.compact end
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
    JSON.parse(response.body)
  end

  def json_data
    json.fetch("data")
  end

  def json_data_id
    json_data.fetch("id")
  end

  def json_data_attributes
    json_data.fetch("attributes")
  end
end
