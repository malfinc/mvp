module V1
  class ApplicationSerializer
    include(JSONAPI::Serializer)

    def base_url
      ENV.fetch("RESOURCES_ORIGIN")
    end

    def relationship_related_link(_attribute_name)
      nil
    end

    def self.has_many(name, options = {}, &block)
      super(name, options.merge(:if => policy_allows_relation?(name)), &policy_scoped(name, &block))
    end

    def self.has_one(name, options = {}, &block)
      super(name, options.merge(:if => policy_allows_relation?(name)), &policy_scoped(name, &block))
    end

    def self.attribute(name, options = {}, &block)
      super(name, options.merge(:if => policy_allows_relation?(name)), &block)
    end

    private_class_method def self.policy_allows(name, type)
      define_method("allow_#{name}?") do
        raise(MissingContextPolicyFinderError) unless context.key?(:policy_finder)

        policy_finder = context.fetch(:policy_finder)

        raise(MissingContextPolicyFinderError) unless policy_finder.kind_of?(Method) || policy_finder.kind_of?(Proc)

        policy = policy_finder.(object)

        raise(MissingContextPolicyFinderError) unless policy.present?

        return false unless policy.respond_to?("read_#{name}?")

        policy.public_send("read_#{name}?")
      end
    end

    private_class_method def self.policy_allows_attribute?(name)
      policy_allows(name, :attribute)
    end

    private_class_method def self.policy_allows_relation?(name)
      policy_allows(name, :related)
    end

    private_class_method def self.policy_scoped(association)
      ->(_) do
        raise(MissingContextPolicyFinderError) unless context.key?(:policy_finder)

        policy_finder = context.fetch(:policy_finder)

        raise(MissingContextPolicyFinderError) unless policy_finder.kind_of?(Method) || policy_finder.kind_of?(Proc)

        policy_scope = policy_finder.(object)

        raise(MissingContextPolicyFinderError) unless policy_scope.present?

        if block_given?
          yield(policy_scope.public_send("related_#{association}"))
        else
          policy_scope.public_send("related_#{association}")
        end
      end
    end
  end
end
