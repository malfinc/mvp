module V1
  class ApplicationRealizer
    @abstract_class = true

    include(JSONAPI::Realizer::Resource)
  end
end
