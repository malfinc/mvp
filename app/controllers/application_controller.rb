class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit
  # before_action :set_locale

  # private def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  private def user_for_paper_trail
    if account_signed_in? then current_account else "Anonymous" end
  end

  private def info_for_paper_trail
    {
      actor_id: if account_signed_in? then current_account.id end,
      ip: request.remote_ip,
      request_id: request.request_id,
      session_id: session.id,
      user_agent: request.user_agent
    }
  end
end
