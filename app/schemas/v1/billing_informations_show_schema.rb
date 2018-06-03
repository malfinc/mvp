module V1
  class BillingInformationsShowSchema < V1::ApplicationSchema
    schema type: Strict::Hash do
      field :id, type: Strict::String
      field :fields, type: Strict::Array.of(Strict::String).optional
      field :include, type: Strict::Array.of(Strict::String).optional
    end
  end
end
