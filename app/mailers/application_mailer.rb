class ApplicationMailer < ActionMailer::Base
  default from: ENVied.APPLICAITON_EMAIL_FROM

  layout 'mailer'
end
