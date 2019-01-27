module V1
  class ApplicationMaterializer
    @abstract_class = true

    include(JSONAPI::Materializer::Resource)

    def readable_attribute?(attribute)
      context.policy.(object).read_attribute?(attribute.from)
    end
  end
end
