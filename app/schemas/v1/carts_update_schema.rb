module V1
  class CartsUpdateSchema < V1::ApplicationSchema
    schema type: Strict::Hash do
      field :data, type: Strict::Hash do
        field :id, type: Coercible::String
        field :type, type: Strict::String
        field :attributes, type: Strict::Hash.optional
        field :relationships, type: Strict::Hash.optional do
          field "shipping-information", type: Strict::Hash.optional do
            field :data, type: Strict::Hash.optional do
              field :id, type: Strict::String.optional
              field :type, type: Strict::String.optional
            end
          end
          field "billing-information", type: Strict::Hash.optional do
            field :data, type: Strict::Hash.optional do
              field :id, type: Strict::String.optional
              field :type, type: Strict::String.optional
            end
          end
        end
      end
      field :meta, type: Strict::Hash.optional
      field :included, type: Strict::Array.optional
      field :fields, type: Strict::Array.of(Strict::String).optional
      field :include, type: Strict::Array.of(Strict::String).optional
    end
  end
end
