class ApplicationMailer < ActionMailer::Base
  default from: ENVied.RAILS_EMAIL_FROM

  layout 'mailer'
end
