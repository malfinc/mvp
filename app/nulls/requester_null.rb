class RequesterNull < ApplicationNull
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
end
