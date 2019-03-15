JSONAPI::Materializer.configuration do |let|
  let.default_origin = Poutineer.settings.fetch("resources_origin")
  let.default_identifier = :id
end
