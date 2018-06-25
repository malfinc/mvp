class MenuItemsController < ApplicationController
  include Authorization

  # GET /menu_items
  def index
    authorize(MenuItem)
    @records = MenuItem.all
  end

  # GET /menu_items/1
  def show
    find_menu_item
  end

  # GET /menu_items/new
  def new
    authenticate_account!
    @record = current_account.menu_items.new
    authorize_record!
  end

  # POST /menu_items
  def create
    authenticate_account!
    @record = current_account.menu_items.new(menu_item_params)
    authorize_record!

    if @record.save!
      redirect_to(@record, :notice => "MenuItem was successfully created.")
    else
      render(:new)
    end
  end

  # PATCH/PUT /menu_items/1
  def update
    authenticate_account!
    find_menu_item
    authorize_record!

    if @record.update!(menu_item_params)
      redirect_to(@record, :notice => "MenuItem was successfully updated.")
    else
      render(:edit)
    end
  end

  private def find_menu_item
    @record = MenuItem.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  private def menu_item_params
    {
      :name => params.fetch(:menu_item, {}).fetch(:name, nil)
    }
  end
end
