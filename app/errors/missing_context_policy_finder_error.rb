class MissingContextPolicyFinderError < ApplicationError
  def detail
    "context needs to have a policy_finder key that is a function"
  end
end
