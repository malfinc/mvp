module V1
  class ApplicationSerializer
    include JSONAPI::Serializer

    def relationship_related_link(attribute_name)
      nil
    end
  end
end
