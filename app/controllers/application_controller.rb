class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception, :prepend => true
  before_action :assign_paper_trail_context
  before_bugsnag_notify :assign_user_context, :if => :account_signed_in?
  before_bugsnag_notify :assign_metadata_tab

  # before_action :set_locale

  # private def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  private def assign_paper_trail_context
    PaperTrail.request.whodunnit = "anonymous@system.local"
    PaperTrail.request.controller_info = {
      :actor_id => nil,
      :group_id => request.request_id
    }

    return if account_signed_in?

    PaperTrail.request.whodunnit = current_account.email
    PaperTrail.request.controller_info = {
      :actor_id => current_account.id,
      :group_id => request.request_id
    }
  end

  private def assign_user_context(report)
    report.user = {
      :email => current_account.email,
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
