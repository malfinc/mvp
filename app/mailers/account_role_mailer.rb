class AccountRoleMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_role_mailer.upgraded_to_administrator.subject
  #
  def upgraded_to_administrator
    mail(:to => params.fetch(:destination).email)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_role_mailer.downgraded_to_user.subject
  #
  def downgraded_to_user
    mail(:to => params.fetch(:destination).email)
  end
end
