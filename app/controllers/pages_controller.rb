class PagesController < ApplicationController
  include HighVoltage::StaticPage

  before_action :authenticate_account!, only: :home
  layout :dynamic_layout

  private def dynamic_layout
    "application"
  end
end
