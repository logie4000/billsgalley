class RecipesController < ApplicationController
  before_action :authorize, only: [:edit, :update, :destroy]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user, only: [:update, :create]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @ingredients = @recipe.ingredients
    @directions = @recipe.directions
  end

  # GET /recipes/1/edit
  def edit
    @recipe.ingredients.build()
    @recipe.directions.build()
  end

  # POST /recipes
  # POST /recipes.json
  def create 
    @recipe = Recipe.new(recipe_params)
    @recipe.author = @current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        p = 0
        @recipe.directions.each do |direction|
          direction.position = p
          direction.save!
          p += 1
        end

        if @recipe.author.nil? && @current_user
          @recipe.author = @current_user
          @recipe.save
        end

        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def welcome
  end

  def about
  end

  def add_ingredient
    @recipe = Recipe.find(params[:id])
    if (@recipe)
      @recipe.ingredients.build()
    end

    respond_to do |format|
      format.js
    end
  end

  def add_ingredient_row
    @recipe = params[:recipe]
    if (@recipe)
      @recipe.ingredients.build()
    else
      Rails.logger.debug "No recipe passed in to add_ingredient_row"
    end

    respond_to do |format|
      format.js
    end
  end

  def add_direction
    @recipe = Recipe.find(params[:id])
    if (@recipe)
      @recipe.directions.build()
    end

    respond_to do |format|
      format.js
    end
  end

  def add_direction_row
    respond_to do |format|
      format.js
    end
  end

  def remove_ingredient
    Rails.logger.debug "remove_ingredient: #{params.inspect}"
    @recipe = Recipe.find(params[:id])
    ingredient = Ingredient.find(params[:ingredient_id])

    @recipe.ingredients.delete(ingredient) if (@recipe)
    
    respond_to do |format|
      format.js
    end
  end

  def remove_direction
    @recipe = Recipe.find(params[:id])
    direction = Direction.find(params[:direction_id])

    @recipe.directions.delete(direction) if (@recipe)

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def set_current_user
      @current_user = User.find(session[:user_id]) if (session[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :description, :user_id, :note, ingredients_attributes: [:id, :position, :value, :_destroy], directions_attributes: [:id, :position, :step, :_destroy])
    end

    def recipe_ingredients_params
      params.require(:recipe).permit(ingredients_attributes: [:id, :position, :value, :_destroy])
    end
end
