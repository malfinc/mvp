class ApplicationController < ActionController::API
  before_action(:assign_paper_trail_context)
  before_bugsnag_notify(:assign_account_context)
  before_bugsnag_notify(:assign_request_tab)
  rescue_from(StandardError, :with => :generic_error_handling)

  etag {current_account&.id}

  private def assign_paper_trail_context
    if account_signed_in?
      PaperTrail.request.whodunnit = current_account.email
    else
      PaperTrail.request.whodunnit = "anonymous@system.local"
    end

    PaperTrail.request.controller_info = {
      :actor_id => if account_signed_in? then current_account.id end,
      :context_id => request.request_id
    }
  end

  private def assign_account_context(report)
    return unless account_signed_in?

    report.user = {
      :id => current_account.id
    }
  end

  private def assign_request_tab(report)
    report.add_tab(
      :request,
      :request_id => request.request_id,
      :session_id => if account_signed_in? then session.id end
    )
  end

  private def generic_error_handling(exception)
    RequestErrorHandlingOperation.(:controller => self, :exception => exception)
  end
end
