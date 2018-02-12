RSpec::Matchers.define :have_pairing do |expected_key, expected_value|
  match do |actual|
    actual.try(:[], expected_key).try(:==, expected_value)
  end

  failure_message do |actual|
    return "expected value does not respond to #[]" unless actual.respond_to?(:[])

    return "expected that the key/value store would have key #{key}" unless actual[expected_key]

    "expected that the key/value store would have key #{expected_key} with value #{expected_value}"
  end
end

RSpec::Matchers.define :have_jsonapi_type do |expected|
  match do |actual|
    Oj.load(actual.try(:body) || "{}").fetch("data", {}).fetch("type", nil) == expected
  end

  failure_message do |actual|
    body = actual.try(:body)
    return "response had no body or was not a response" unless body.present?

    native = Oj.load(body)
    @actual = body
    return "response was not valid json" unless native.present?

    data = native["data"]
    @actual = native
    return "the payload didn't have the data attribute or was empty" unless data.present?

    type = data["type"]
    @actual = data
    return "data.type property either didn't have a value or didn't exist" unless type.present?

    "expected that the JSON:API response type #{type} would be #{expected}"
  end
end

RSpec::Matchers.define :have_jsonapi_attributes do |expected|
  match do |actual|
    values_match?(hash_including(expected), Oj.load(actual.try(:body) || "{}").fetch("data", {}).fetch("attributes", {}))
  end

  failure_message do |actual|
    body = actual.try(:body)
    return "response had no body or was not a response" unless body.present?

    native = Oj.load(body)
    @actual = body
    return "response was not valid json" unless native.present?

    data = native["data"]
    @actual = native
    return "the payload didn't have the data attribute or was empty" unless data.present?

    attributes = data["attributes"]
    @actual = data
    return "data.attributes property either didn't have a value or didn't exist" unless attributes.present?

    "expected that the JSON:API response attributes #{attributes.inspect} would match #{expected.inspect}"
  end

  diffable
end

RSpec::Matchers.define :have_jsonapi_related do |expected_name, expected_related_data|
  match do |actual|
    values_match?(expected_related_data, Oj.load(actual.try(:body) || "{}").fetch("data", {}).fetch("relationships", {}).fetch(expected_name, {}).fetch("data", nil))
  end

  failure_message do |actual|
    body = actual.try(:body)
    return "response had no body or was not a response" unless body.present?

    native = Oj.load(body)
    @actual = body
    return "response was not valid json" unless native.present?

    data = native["data"]
    @actual = native
    return "the payload didn't have the data attribute or was empty" unless data.present?

    relationships = data["relationships"]
    @actual = data
    return "data.relationships property either didn't have a value or didn't exist" unless relationships.present?

    related = relationships[expected_name]
    @actual = relationships
    return "data.relationships.#{expected_name} property either didn't have a value or didn't exist" unless related.present?


    related_data = related["data"]
    @actual = related
    return "data.relationships.#{expected_name}.data property either didn't have a value or didn't exist" unless related_data.present?

    "expected that the JSON:API response relationships #{related_data.inspect} would match #{expected_related_data}.inspect}"
  end

  diffable
end
