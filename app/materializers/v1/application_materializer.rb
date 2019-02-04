module V1
  class ApplicationMaterializer
    @abstract_class = true

    include(JSONAPI::Materializer::Resource)

    def readable?(attribute)
      context.policy.(object).readable?(attribute.from)
    end
  end
end
