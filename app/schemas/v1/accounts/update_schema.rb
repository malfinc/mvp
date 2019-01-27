module V1
  module Accounts
    class UpdateSchema < V1::ApplicationSchema
      schema(:type => Strict::Hash) do
        field(:data, :type => Strict::Hash) do
          field(:id, :type => Coercible::String)
          field(:type, :type => Strict::String)
          field(:attributes, :type => Strict::Hash) do
            field(:email, :type => Strict::String.optional)
            field(:username, :type => Strict::String.optional)
            field(:name, :type => Strict::String.optional)
          end
        end
        field(:meta, :type => Strict::Hash.optional)
        field(:included, :type => Strict::Array.optional)
        field(:fields, :type => Strict::Hash.map(Strict::String, Strict::String).optional)
        field(:include, :type => (Strict::String || Strict::Array.of(Strict::String)).optional)
      end
    end
  end
end
