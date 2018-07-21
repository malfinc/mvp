module V1
  class ApplicationSerializer
    include(JSONAPI::Serializer)

    def relationship_related_link(_attribute_name)
      nil
    end
  end
end
