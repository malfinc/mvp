JSONAPI::Materializer.configuration do |let|
  let.default_origin = ENV.fetch("RESOURCES_ORIGIN")
  let.default_identifier = :id
end
