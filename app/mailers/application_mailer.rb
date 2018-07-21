class ApplicationMailer < ActionMailer::Base
  default(:from => "#{ENV.fetch("RAILS_EMAIL_USER")}@#{ENV.fetch("RAILS_EMAIL_HOST")}")

  layout("mailer")
end
