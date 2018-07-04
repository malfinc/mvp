class PagesController < ApplicationController
  include HighVoltage::StaticPage

  layout "page"

  before_action :only => :show do
    case params.fetch(:id)
    when "frontpage"
      authenticate_account!
    when "landing"
      if account_signed_in?
        redirect_to(frontpage_path())
      end
    end
  end
end
