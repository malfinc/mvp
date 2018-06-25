# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_account!
    before_action :authorize_administrator!
    before_action :set_paper_trail_whodunnit
    before_bugsnag_notify :assign_user_context, :if => :account_signed_in?
    before_bugsnag_notify :assign_session_tab

    def authorize_administrator!
      raise(Pundit::NotAuthorizedError) unless current_account.administrator?
    end

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

    private def assign_session_tab(report)
      report.add_tab(
        :session,
        {
          actor: PaperTrail.request.whodunnit,
          request_id: request.request_id,
          session_id: if account_signed_in? then session.id end,
        }
      )
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
