class ApplicationMailer < ActionMailer::Base
  default(:from => Poutineer.settings.fetch_deep(:rails, :email_default))

  layout(:mailer)
end
