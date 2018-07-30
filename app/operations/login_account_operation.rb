class LoginAccountOperation < ApplicationOperation
  task(:find_account)
  task(:validate_password)
  catch(:reraise)

  schema(:find_account) do
    field(:shared, :type => Types::Strict::String)
    field(:secret, :type => Types::Strict::String)
  end
  def find_account(state:)
    fresh(
      :state => {
        :account => Account.find_for_database_authentication(:email => state.shared) || raise(InvalidLoginError),
        :secret => secret
      }
    )
  end

  schema(:validate_password) do
    field(:account, :type => Types.Instance(Account))
    field(:secret, :type => Types::Strict::String)
  end
  def validate_password(state:)
    raise InvalidLoginError unless account.valid_password?(state.secret)

    fresh(
      :state => {
        :account => account
      }
    )
  end
end
