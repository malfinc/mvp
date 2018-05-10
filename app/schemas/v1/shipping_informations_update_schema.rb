module V1
  class ShippingInformationsUpdateSchema < V1::ApplicationSchema
    schema type: Strict::Hash do
      field :data, type: Strict::Hash do
        field :id, type: Coercible::String
        field :type, type: Strict::String
        field :attributes, type: Strict::Hash
      end
      field :meta, type: Strict::Hash.optional
      field :included, type: Strict::Array.optional
      field :fields, type: Strict::Array.of(Strict::String).optional
      field :include, type: Strict::Array.of(Strict::String).optional
    end
  end
end
