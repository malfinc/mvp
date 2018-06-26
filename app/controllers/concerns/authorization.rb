module Authorization
  extend ActiveSupport::Concern
  include Pundit

  included do
    after_action :verify_authorized
    after_action :verify_policy_scoped

    rescue_from Pundit::NotAuthorizedError, :with => :account_not_authorized
  end

  private def authorize_record!
    authorize(@record)
  end

  private def pundit_user
    current_account
  end

  private def account_not_authorized(exception)
    Rails.logger.debug("Pundit #{exception.policy.class.name} did not authorize #{exception.query}")
    flash[:alert] = t("#{exception.policy.class.name.underscore}.#{exception.query}", :scope => "pundit", :default => :default)
    redirect_to(request.referer || root_path)
  end
end
