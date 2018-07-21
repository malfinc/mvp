RSpec::Matchers.define(:have_pairing) do |expected_key, expected_value|
  match do |actual|
    actual.try(:[], expected_key).try(:==, expected_value)
  end

  failure_message do |actual|
    return "expected value does not respond to #[]" unless actual.respond_to?(:[])

    return "expected that the key/value store would have key #{key}" unless actual[expected_key]

    "expected that the key/value store would have key #{expected_key} with value #{expected_value}"
  end
end

RSpec::Matchers.define(:have_jsonapi_type) do |expected|
  match do |actual|
    Oj
      .load(actual&.body.presence || "{}")
      .fetch("data", {})
      .fetch("type", nil) == expected
  end

  failure_message do |actual|
    body = actual&.body
    return "response had no body or was not a response" if body.blank?

    native = Oj.load(body)
    @actual = body
    return "response was not valid json" if native.blank?

    data = native["data"]
    @actual = native
    return "the payload didn't have the data attribute or was empty" if data.blank?

    type = data["type"]
    @actual = data
    return "data.type property either didn't have a value or didn't exist" if type.blank?

    "expected that the JSON:API response type #{type} would be #{expected}"
  end
end

RSpec::Matchers.define(:have_jsonapi_attributes) do |expected|
  match do |actual|
    values_match?(
      hash_including(expected),
      Oj
        .load(actual&.body.presence || "{}")
        .fetch("data", {})
        .fetch("attributes", {})
    )
  end

  failure_message do |actual|
    body = actual&.body
    return "response had no body or was not a response" if body.blank?

    native = Oj.load(body)
    @actual = body
    return "response was not valid json" if native.blank?

    data = native["data"]
    @actual = native
    return "the payload didn't have the data attribute or was empty" if data.blank?

    attributes = data["attributes"]
    @actual = data
    return "data.attributes property either didn't have a value or didn't exist" if attributes.blank?

    "expected that the JSON:API response attributes #{attributes.inspect} would match #{expected.inspect}"
  end

  diffable
end

RSpec::Matchers.define(:have_jsonapi_related) do |expected_name, expected_related_data|
  match do |actual|
    values_match?(
      expected_related_data,
      Oj
        .load(actual&.body.presence || "{}")
        .fetch("data", {})
        .fetch("relationships", {})
        .fetch(expected_name, {})
        .fetch("data", nil)
    )
  end

  failure_message do |actual|
    body = actual&.body
    return "response had no body or was not a response" if body.blank?

    native = Oj.load(body)
    @actual = body
    return "response was not valid json" if native.blank?

    data = native["data"]
    @actual = native
    return "the payload didn't have the data attribute or was empty" if data.blank?

    relationships = data["relationships"]
    @actual = data
    return "data.relationships property either didn't have a value or didn't exist" if relationships.blank?

    related = relationships[expected_name]
    @actual = relationships
    return "data.relationships.#{expected_name} property either didn't have a value or didn't exist" if related.blank?

    related_data = related["data"]
    @actual = related
    return "data.relationships.#{expected_name}.data property either didn't have a value or didn't exist" if related_data.blank?

    "expected that the JSON:API response relationships #{related_data.inspect} would match #{expected_related_data}.inspect}"
  end

  diffable
end
