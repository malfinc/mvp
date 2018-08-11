module JsonapiSerializersClassLookup
  def find_serializer_class_name(object, options)
    if object.respond_to?(:jsonapi_serializer_class_name) && options.key?(:namespace)
      return "#{options[:namespace]}::#{object.jsonapi_serializer_class_name}"
    end

    if object.respond_to?(:jsonapi_serializer_class_name)
      return object.jsonapi_serializer_class_name.to_s
    end

    if options[:namespace]
      return "#{options[:namespace]}::#{object.class.name}Serializer"
    end

    "#{object.class.name}Serializer"
  end
end

JSONAPI::Serializer.singleton_class.prepend(JsonapiSerializersClassLookup)
