module V1
  class AccountRealizer
    include(JSONAPI::Realizer::Resource)
    include(Pundit)

    register(:accounts, :class_name => "Account", :adapter => :active_record)

    has(:email)
  end
end
