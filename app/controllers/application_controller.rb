class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception, :prepend => true
  before_action :set_paper_trail_whodunnit
  before_bugsnag_notify :assign_user_context, :if => :account_signed_in?
  before_bugsnag_notify :assign_metadata_tab

  # before_action :set_locale

  # private def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  private def user_for_paper_trail
    if account_signed_in? then current_account else "Anonymous" end
  end

  private def info_for_paper_trail
    {
      :actor_id => if account_signed_in? then current_account.id end,
      :group_id => request.request_id
    }
  end

  private def assign_user_context(report)
    report.user = {
      :email => current_account.email,
      :name => current_account.name,
      :username => current_account.username,
      :slug => current_account.slug,
      :id => current_account.id
    }
  end

  private def assign_metadata_tab(report)
    report.add_tab(
      :metadata,
      :request_id => request.request_id,
      :session_id => if account_signed_in? then session.id end
    )
  end
end
