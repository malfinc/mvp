class ApplicationMailer < ActionMailer::Base
  default from: ENV["APPLICAITON_EMAIL_FROM"]

  layout 'mailer'
end
