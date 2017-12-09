case
when ENV["MAILTRAP_API_TOKEN"]
  JSON.parse(open("https://mailtrap.io/api/v1/inboxes.json?api_token=#{ENV["MAILTRAP_API_TOKEN"]}").read).first.tap do |inbox|
    ActionMailer::Base.smtp_settings = {
      user_name: inbox["username"],
      password: inbox["password"],
      address: inbox["domain"],
      domain: ENVied.RAILS_HOST,
      port: inbox["smtp_ports"].first,
      authentication: :plain
    }
  end
when ENV["MAILGUN_SMTP_PORT"]
  ActionMailer::Base.smtp_settings = {
    user_name: ENV["MAILGUN_SMTP_LOGIN"],
    password: ENV["MAILGUN_SMTP_PASSWORD"],
    address: ENV["MAILGUN_SMTP_SERVER"],
    domain: ENVied.RAILS_HOST,
    port: ENV["MAILGUN_SMTP_PORT"],
    authentication: :plain,
  }
end

ActionMailer::Base.delivery_method = :smtp
