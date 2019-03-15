module V1
  class ApplicationMaterializer
    @abstract_class = true

    include(JSONAPI::Materializer::Resource)
  end
end
