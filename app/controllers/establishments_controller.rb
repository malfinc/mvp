class EstablishmentsController < ApplicationController
  include Authorization

  # GET /establishments
  def index
    authorize(Establishment)
    @records = Establishment.all
  end

  # GET /establishments/1
  def show
    find_establishment
    authorize_record!
  end

  # GET /establishments/new
  def new
    authenticate_account!
    @record = current_account.establishments.new
    authorize_record!
  end

  # POST /establishments
  def create
    authenticate_account!
    @record = current_account.establishments.new(establishment_params)
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
    find_establishment
    authorize_record!

    if @record.update!(establishment_params)
      redirect_to(@record, :notice => "Establishment was successfully updated.")
    else
      render(:edit)
    end
  end

  private def find_establishment
    @record = Establishment.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  private def establishment_params
    {
      :name => params.fetch(:establishment, {}).fetch(:name, nil)
    }
  end
end
