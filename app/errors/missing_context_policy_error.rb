class MissingContextPolicyError < ApplicationError
  def detail
    "context needs to have a policy"
  end
end
