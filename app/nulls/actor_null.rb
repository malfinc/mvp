class ActorNull < ApplicationNull
  attr_accessor :id
  attr_accessor :name
  attr_accessor :username

  def self.model_name
    OpenStruct.new(:route_key => "accounts")
  end
end
