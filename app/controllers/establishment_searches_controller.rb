class EstablishmentSearchesController < ApplicationController
  include Authorization

  # GET /establishment_searches/1
  def show
    authenticate_account!
    find_record
    authorize_record!
  end

  # GET /establishment_searches/new
  def new
    authenticate_account!
    @record = pundit_scoped.new
    authorize_record!
  end

  # POST /establishment_searches
  def create
    authenticate_account!
    @record = pundit_scoped.new(establishment_search_params)
    @record.assign_attributes(:results => GOOGLE_PLACES_CLIENT.spots_by_query(@record.query))
    authorize_record!

    if @record.valid?
      redirect_to(@record, :notice => "We finally got those search results from google.")
    else
      render(:new)
    end
  end

  private def find_record
    @record = EstablishmentSearchDecorator.decorate(pundit_scoped.new(:id => params[:id]))
  end

  # Only allow a trusted parameter "white list" through.
  private def establishment_search_params
    {
      :query => params.fetch(:establishment_search, {}).fetch(:query, nil)
    }
  end

  private def pundit_scoped
    policy_scope(EstablishmentSearch)
  end
end
