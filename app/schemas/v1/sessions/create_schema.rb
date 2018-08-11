module V1
  module Sessions
    class CreateSchema < V1::ApplicationSchema
      schema(:type => Strict::Hash) do
        field(:data, :type => Strict::Hash) do
          field(:type, :type => Strict::String)
          field(:attributes, :type => Strict::Hash) do
            field(:email, :type => Strict::String)
            field(:password, :type => Strict::String)
          end
        end
        field(:meta, :type => Strict::Hash.optional)
        field(:fields, :type => Strict::Array.of(Strict::String).optional)
        field(:include, :type => Strict::Array.of(Strict::String).optional)
      end
    end
  end
end
