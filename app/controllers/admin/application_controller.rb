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

    def authorize_administrator!
      raise(Pundit::NotAuthorizedError) unless current_account.administrator?
    end

    private def user_for_paper_trail
      current_account
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
