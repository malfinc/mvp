class MutationType < BaseObjectType
  field(:create_account, :mutation => CreateAccountMutation)
end
