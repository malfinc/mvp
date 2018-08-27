module V1
  class AccountRealizer
    include(JSONAPI::Realizer::Resource)
    include(Pundit)

    register(:accounts, :class_name => "Account", :adapter => :active_record)

    has_many(:payments, as: :payments)

    has(:email)
  end
end
