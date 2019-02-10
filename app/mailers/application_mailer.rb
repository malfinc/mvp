class ApplicationMailer < ActionMailer::Base
  default(:from => BlankApiRails.configuration.fetch_deep(:rails, :email_default))

  layout(:mailer)
end
