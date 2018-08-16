class LoginAccountOperation < ApplicationOperation
  task(:find_account)
  task(:validate_password)
  catch(:reraise)

  schema(:find_account) do
    field(:scope, :type => Types.Constant(Account))
    field(:shared, :type => Types::Strict::String)
    field(:secret, :type => Types::Strict::String)
  end
  def find_account(state:)
    fresh(
      :state => {
        :account => state.scope.find_for_database_authentication(:email => state.shared) || raise(InvalidLoginError),
        :secret => state.secret
      }
    )
  end

  schema(:validate_password) do
    field(:account, :type => Types.Instance(Account))
    field(:secret, :type => Types::Strict::String)
  end
  def validate_password(state:)
    raise(InvalidLoginError) unless state.account.valid_password?(state.secret)

    fresh(
      :state => {
        :account => state.account
      }
    )
  end
end
