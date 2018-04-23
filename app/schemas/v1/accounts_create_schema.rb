module V1
  class AccountsCreateSchema < V1::ApplicationSchema
    schema type: Strict::Hash do
      field :data, type: Strict::Hash do
        field :id, type: Coercible::String.optional
        field :type, type: Strict::String
        field :attributes, type: Strict::Hash.optional do
          field :email, type: Strict::String.optional
          field :username, type: Strict::String.optional
          field :name, type: Strict::String.optional
          field :password, type: Strict::String.optional.default { SecureRandom.hex(32) }
        end
      end
      field :meta, type: Strict::Hash.optional
      field :included, type: Strict::Array.optional
      field :fields, type: Strict::Array.of(Strict::String).optional
      field :include, type: Strict::Array.of(Strict::String).optional
    end
  end
end
