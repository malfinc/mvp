class ApplicationResource < JSONAPI::Resource
  abstract

  cattr_accessor :_controller_contexts do
    []
  end
  cattr_accessor :_additional_primary_keys do
    []
  end

  def self.record_context(key)
    _controller_contexts << key
  end

  def self.create(context = {})
    super(context).tap do |resource|
      _controller_contexts.each do |key|
        resource._model.public_send("#{key}=", context[key])
      end
    end
  end

  def self.additional_primary_key(key)
    _additional_primary_keys << key
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

  def self.monetize(name)
    attribute name
    attribute "#{name}_cents".to_sym
    attribute "#{name}_currency".to_sym

    define_method(name) do
      @model.public_send(name).format
    end
  end
end
