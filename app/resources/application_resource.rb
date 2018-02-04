class ApplicationResource < JSONAPI::Resource
  abstract

  def self.record_context(key)
    define_singleton_method(:create) do |context|
      super(context).tap do |resource|
        resource._model.public_send("#{key}=", context[key])
      end
    end
  end

  def self.additional_primary_keys(*keys)
    @_additional_primary_keys = keys
  end

  def self._additional_primary_keys
    @_additional_primary_keys || []
  end

  def self.find_by_key(key, options = {})
    records = apply_includes(records(options), options)

    model = _additional_primary_keys.reduce(records.where(_primary_key => key)) {|scope, column| scope.or(records.where(column => key))}.first

    raise JSONAPI::Exceptions::RecordNotFound.new(key) unless model

    self.resource_for_model(model).new(model, options[:context])
  end

  def self.apply_includes(records, options = {})
    include_directives = options[:include_directives]

    return records unless include_directives

    clean_includes(records, resolve_relationship_names_to_relations(self, include_directives.model_includes, options))
  end

  def self.clean_includes(records, includes)
    includes.reduce(records) do |accumulation, including|
      if including.respond_to?(:keys)
        accumulation.includes(including.keys.reject(&records.nonincludable_associations.method(:include?)))
      else
        unless records.nonincludable_associations.include?(including)
          accumulation.includes(including)
        else
          accumulation
        end
      end
    end
  end
end
