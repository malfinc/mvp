# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

Mime::Type.register("application/vnd.api+json", :json)

ActionDispatch::Http::Parameters::DEFAULT_PARSERS[:json] = ->(body) do
  begin
    parsed_body = Oj.load(body) if body.present?

    raise(BadError) unless parsed_body.is_a?(Hash)

    parsed_body.with_indifferent_access
  rescue JSON::ParserError => parse_exception
    # TODO: Handle parse error
    raise(parse_exception)
  end
end

# ActionDispatch::Request.parameter_parsers = ActionDispatch::Request::DEFAULT_PARSERS
