class RecipesController < ApplicationController
  include Authorization

  # GET /recipes
  def index
    authorize(pundit_scoped)
    find_records
  end

  # GET /recipes/1
  def show
    find_record
    authorize_record!
  end

  # GET /recipes/new
  def new
    authenticate_account!
    @record = RecipeDecorator.decorate(pundit_scoped.new)
    @record.assign_attributes(:author => current_account)
    authorize_record!
  end

  # GET /recipes/1/edit
  def edit
    authenticate_account!
    find_record
    authorize_record!
  end

  # POST /recipes
  def create
    authenticate_account!
    @record = pundit_scoped.new(recipe_params)
    @record.assign_attributes(:author => current_account)
    authorize_record!

    if @record.save!
      redirect_to(@record, :notice => "Recipe was successfully created.")
    else
      render(:new)
    end
  end

  # PATCH/PUT /recipes/1
  def update
    authenticate_account!
    find_record
    authorize_record!

    if @record.update!(submission_params)
      redirect_to(@record, :notice => "Submission was successfully updated.")
    else
      render(:edit)
    end
  end

  # DELETE /recipes/1
  def destroy
    authenticate_account!
    find_record
    authorize_record!
    @record.destroy!

    redirect_to(recipes_url, :notice => "Recipe was successfully destroyed.")
  end

  # Only allow a trusted parameter "white list" through.
  private def recipe_params
    {
      :name => params.fetch(:recipe, {}).fetch(:name, nil),
      :description => params.fetch(:recipe, {}).fetch(:description, nil),
      :ingredients => params.fetch(:recipe, {}).fetch(:ingredients, nil),
      :instructions => params.fetch(:recipe, {}).fetch(:instructions, nil),
      :diets => params.fetch(:recipe, {}).fetch(:diets, nil),
      :allergies => params.fetch(:recipe, {}).fetch(:allergies, nil)
    }
  end

  private def find_record
    @record = RecipeDecorator.decorate(pundit_scoped.friendly.find(params[:id]))
  end

  private def find_records
    @records = RecipeDecorator.decorate_collection(pundit_scoped)
  end

  private def pundit_scoped
    policy_scope(Recipe)
  end
end
