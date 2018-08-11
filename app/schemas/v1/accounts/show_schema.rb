module V1
  module Establishments
    class ShowSchema < V1::ApplicationSchema
      schema(:type => Strict::Hash) do
        field(:id, :type => Strict::String)
        field(:fields, :type => Strict::Array.of(Strict::String).optional)
        field(:include, :type => Strict::Array.of(Strict::String).optional)
      end
    end
  end
end
