class ApplicationMailer < ActionMailer::Base
  default(:from => Poutineer.configuration.fetch_deep(:rails, :email_default))

  layout(:mailer)
end
