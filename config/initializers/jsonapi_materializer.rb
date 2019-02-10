JSONAPI::Materializer.configuration do |let|
  let.default_origin = BlankApiRails.configuration.fetch("resources_origin")
  let.default_identifier = :id
end
