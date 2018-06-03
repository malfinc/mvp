module V1
  class BillingInformationsUpdateSchema < V1::ApplicationSchema
    schema type: Strict::Hash do
      field :id, type: Strict::String
      field :data, type: Strict::Hash do
        field :id, type: Coercible::String
        field :type, type: Strict::String
        field :attributes, type: Strict::Hash do
          field :name, type: Strict::String.optional
          field :address, type: Strict::String.optional
          field :city, type: Strict::String.optional
          field :state, type: Strict::String.optional
          field :postal, type: Strict::String.optional
        end
        field :relationships, type: Strict::Hash.optional do
          field :carts, type: Strict::Array.of(Strict::Hash).optional
        end
      end
      field :meta, type: Strict::Hash.optional
      field :included, type: Strict::Array.optional
      field :fields, type: Strict::Array.of(Strict::String).optional
      field :include, type: Strict::Array.of(Strict::String).optional
    end
  end
end
