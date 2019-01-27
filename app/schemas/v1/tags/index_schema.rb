module V1
  module Tags
    class IndexSchema < V1::ApplicationSchema
      schema(:type => Strict::Hash) do
        field(:fields, :type => Strict::Hash.map(Strict::String, Strict::String).optional)
        field(:include, :type => (Strict::String || Strict::Array.of(Strict::String)).optional)
        field(:page, :type => Strict::Hash.optional) do
          field(:limit, :type => Coercible::Integer.optional.default(10))
          field(:offset, :type => Coercible::Integer.optional.default(1))
        end
        field(:sort, :type => Strict::String.optional)
        field(:filter, :type => Strict::Hash.map(Strict::String, Strict::String || Strict::Integer).optional)
      end
    end
  end
end
