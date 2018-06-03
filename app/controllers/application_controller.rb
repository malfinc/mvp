class ApplicationController < ActionController::API

  before_action :set_paper_trail_whodunnit
  before_bugsnag_notify :set_bugsnag_context
  after_action :verify_authorized
  after_action :verify_policy_scoped

  private def pundit_user
    current_account
  end

  private def user_for_paper_trail
    if account_signed_in? then current_account else "Anonymous" end
  end

  private def info_for_paper_trail
    {
      actor_id: if account_signed_in? then current_account.id end,
      request_id: request.request_id,
      session_id: if account_signed_in? then session.id end
    }
  end

  private def set_bugsnag_context(report)
    if account_signed_in?
      report.user = {
        email: current_account.email,
        name: current_account.name,
        username: current_account.username,
        slug: current_account.slug,
        id: current_account.id,
      }
    end

    report.add_tab(:session, {
      actor: PaperTrail.request.whodunnit,
      session_id: session.id,
    })
  end
end
