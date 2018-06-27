class EstablishmentsController < ApplicationController
  include Authorization

  # GET /establishments
  def index
    authorize(Establishment)
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
end
