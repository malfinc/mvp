module V1
  class ApplicationSerializer
    include(JSONAPI::Serializer)

    def relationship_related_link(_attribute_name)
      nil
    end

    private_class_method def self.policy_allows(name, type)
      define_method("allow_#{type}_#{name}?") do
        if context.key?(:policy) && context.fetch(:policy).respond_to?("read_#{name}?")
          context.fetch(:policy).public_send("read_#{name}?", name)
        elsif context.key?(:policy)
          nil
        else
          raise(MissingContextPolicyError)
        end
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
        raise(MissingContextPolicyError) unless context.key?(:policy)

        context.fetch(:policy).public_send("related_#{association}", if block_given? then yield end)
      end
    end
  end
end
