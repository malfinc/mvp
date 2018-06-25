class PagesController < ApplicationController
  include HighVoltage::StaticPage

  before_action :authenticate_account!, :only => :home
  layout "page"
end
