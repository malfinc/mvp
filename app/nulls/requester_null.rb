class RequesterNull < ApplicationNull
  attr_accessor(:id)
  attr_accessor(:role_state)
  attr_accessor(:onboarding_state)

  def id
    nil
  end

  def role_state?(*)
    false
  end

  def onboarding_state?(*)
    false
  end

  def nil?
    true
  end

  def present?
    false
  end

  def blank?
    !present?
  end
end
