class RecipesController < ApplicationController
  # GET /recipes
  def index
    @records = Recipe.all
  end

  # GET /recipes/1
  def show
    find_recipe
  end

  # GET /recipes/new
  def new
    authenticate_account!
    @record = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    authenticate_account!
    find_recipe
    authorize_account!
  end

  # POST /recipes
  def create
    authenticate_account!
    @record = Recipe.new(recipe_params)
    authorize_account!

    if @record.save
      redirect_to @record, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1
  def update
    authenticate_account!
    find_recipe
    authorize_account!

    if @record.update(recipe_params)
      redirect_to @record, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /recipes/1
  def destroy
    authenticate_account!
    find_recipe
    authorize_account!
    @record.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
  end

  private def find_recipe
    @record = Recipe.friendly.find(params[:id])
  end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
      {
        name: params.fetch(:recipe, {}).fetch(:name, nil),
        description: params.fetch(:recipe, {}).fetch(:description, nil),
        ingredients: params.fetch(:recipe, {}).fetch(:ingredients, nil)
      }
    end
end
