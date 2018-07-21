class ActorNull < ApplicationNull
  attr_accessor(:id)
  attr_accessor(:name)
  attr_accessor(:username)
  attr_accessor(:email)

  def self.model_name
    OpenStruct.new(:route_key => "accounts")
  end
end
