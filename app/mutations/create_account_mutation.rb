class CreateAccountMutation < GraphQL::Schema::Mutation
  argument(:email, String, :required => true)
  argument(:password, String, :required => true)

  field(:errors, [String], :null => false)

  def resolve(email:, password:)
    account = Account.create!(:email => email, :password => password)

    {
      :errors => [],
    }
  rescue ActiveRecord::RecordInvalid => record_invalid_exception
    {
      :errors => record_invalid_exception.record.errors.full_messages,
    }
  end
end
