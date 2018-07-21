module V1
  class DeliveryInformationsCreateSchema < V1::ApplicationSchema
    schema(:type => Strict::Hash) do
      field(:id, :type => Coercible::String.optional)
      field(:data, :type => Strict::Hash) do
        field(:id, :type => Coercible::String.optional)
        field(:type, :type => Strict::String)
        field(:attributes, :type => Strict::Hash) do
          field(:name, :type => Strict::String)
          field(:address, :type => Strict::String)
          field(:city, :type => Strict::String)
          field(:state, :type => Strict::String)
          field(:postal, :type => Strict::String)
        end
        field(:relationships, :type => Strict::Hash.optional) do
          field(:carts, :type => Strict::Array.of(Strict::Hash).optional)
        end
      end
      field(:meta, :type => Strict::Hash.optional)
      field(:included, :type => Strict::Array.optional)
      field(:fields, :type => Strict::Array.of(Strict::String).optional)
      field(:include, :type => Strict::Array.of(Strict::String).optional)
    end
  end
end
