Rails.application.config.action_mailer.default_url_options = {
  host: ENVied.RAILS_HOST,
  port: ENV["PORT"]
}

ActionMailer::Base.delivery_method = :smtp

case
when ENV["MAILTRAP_API_TOKEN"]
  JSON.parse(open("https://mailtrap.io/api/v1/inboxes.json?api_token=#{ENV["MAILTRAP_API_TOKEN"]}")).first.tap do |inbox|
    ActionMailer::Base.smtp_settings = {
      user_name: first_inbox["username"],
      password: first_inbox["password"],
      address: first_inbox["domain"],
      domain: first_inbox["domain"],
      port: first_inbox["smtp_ports"].first,
      authentication: :plain
    }
  end
when ENV["MAILGUN_SMTP_PORT"]
  ActionMailer::Base.smtp_settings = {
    user_name: ENV["MAILGUN_SMTP_LOGIN"],
    password: ENV["MAILGUN_SMTP_PASSWORD"],
    address: ENV["MAILGUN_SMTP_SERVER"],
    domain: ENV["RAILS_HOST"],
    port: ENV["MAILGUN_SMTP_PORT"],
    authentication: :plain,
  }
end
