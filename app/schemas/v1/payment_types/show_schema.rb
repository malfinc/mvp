module V1
  module PaymentTypes
    class ShowSchema < V1::ApplicationSchema
      schema(:type => Strict::Hash) do
        field(:id, :type => Strict::String)
        field(:fields, :type => Strict::Hash.map(Strict::String, Strict::String).optional)
        field(:include, :type => (Strict::String || Strict::Array.of(Strict::String)).optional)
      end
    end
  end
end
