class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit
  # before_action :set_locale

  # private def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  private def authorize_account!
    true
  end

  private def user_for_paper_trail
    Rails.logger.info("Test")
    Rails.logger.info("account_signed_in?: #{account_signed_in?}")
    Rails.logger.info("current_account: #{current_account}")
    if account_signed_in? then current_account else "Anonymous" end
  end

  private def def info_for_paper_trail
    {
      actor_id: if account_signed_in? then current_account.id end,
      ip: request.remote_ip,
      request_id: request.request_id,
      session_id: session_id,
      user_agent: request.user_agent
    }
  end
end
