if ENV.fetch("MAILTRAP_API_TOKEN", nil)
  JSON.parse(open("https://mailtrap.io/api/v1/inboxes.json?api_token=#{ENV.fetch("MAILTRAP_API_TOKEN")}").read).first.tap do |inbox|
    ActionMailer::Base.smtp_settings = {
      :user_name => inbox.fetch("username"),
      :password => inbox.fetch("password"),
      :address => inbox.fetch("domain"),
      :domain => ENV.fetch("RAILS_HOST"),
      :port => inbox.fetch("smtp_ports").first,
      :authentication => :plain
    }
  end

  ActionMailer::Base.delivery_method = :smtp
end

if ENV.fetch("MAILGUN_SMTP_LOGIN", nil)
  ActionMailer::Base.smtp_settings = {
    :user_name => ENV.fetch("MAILGUN_SMTP_LOGIN"),
    :password => ENV.fetch("MAILGUN_SMTP_PASSWORD"),
    :address => ENV.fetch("MAILGUN_SMTP_SERVER"),
    :domain => ENV.fetch("RAILS_HOST"),
    :port => ENV.fetch("MAILGUN_SMTP_PORT"),
    :authentication => :plain
  }

  ActionMailer::Base.delivery_method = :smtp
end
