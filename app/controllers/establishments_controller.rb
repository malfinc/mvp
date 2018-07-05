class EstablishmentsController < ApplicationController
  include Authorization

  # GET /establishments
  def index
    authorize(pundit_scoped)
    find_records
  end

  # GET /establishments/1
  def show
    find_record
    authorize_record!
  end

  # GET /establishments/new
  def new
    authenticate_account!
    @record = pundit_scoped.new
    authorize_record!
  end

  # POST /establishments
  def create
    authenticate_account!
    @record = pundit_scoped.new(establishment_params)
    authorize_record!

    if @record.save!
      redirect_to(@record, :notice => "Establishment was successfully created.")
    else
      render(:new)
    end
  end

  # PATCH/PUT /establishments/1
  def update
    authenticate_account!
    find_record
    authorize_record!

    if @record.update!(establishment_params)
      redirect_to(@record, :notice => "Establishment was successfully updated.")
    else
      render(:edit)
    end
  end

  private def find_record
    @record = EstablishmentDecorator.decorate(pundit_scoped.friendly.find(params[:id]))
  end

  private def find_records
    @records = EstablishmentDecorator.decorate_collection(pundit_scoped)
  end

  private def pundit_scoped
    policy_scope(Establishment)
  end

  # Only allow a trusted parameter "white list" through.
  private def establishment_params
    {
      :name => params.fetch(:establishment, {}).fetch(:name, nil),
      :google_places_id => params.fetch(:establishment, {}).fetch(:google_places_id, nil)
    }
  end
end
