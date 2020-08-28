class RecipesController < ApplicationController
    def show
        @recipe = Recipe.find(params[:id])
    end
    def index
        @recipes = Recipe.all
    end
    def new
        @recipe_form = RecipeForm.new
    end
    def create
        @recipe_form = RecipeForm.new
        @recipe_form.apply(recipe_form_params)
    
        if @recipe_form.valid?
          recipe = Recipe.new(@recipe_form.to_attributes.merge())
          Recipe.transaction do
            if @recipe_form.image_uploaded?
              image = Image.create!(@recipe_form.to_image_attributes)
              recipe.image_id = image.id
            end
            recipe.save!
          end
          redirect_to recipe, notice: 'Recipe was successfully created.'
        else
          render :new
        end
    end
    def destroy
      recipe = Recipe.find(params[:id])
      recipe.destroy
      redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
    end
    def edit
      @recipe = Recipe.find(params[:id])
      @recipe_form = RecipeForm.new(@recipe)
    end
    def update
      @recipe = Recipe.find(params[:id])
      @recipe_form = RecipeForm.new(@recipe)
      @recipe_form.apply(recipe_form_params)
  
      if @recipe_form.valid?
        Recipe.transaction do
          @recipe.steps.destroy_all
          @recipe.ingredients.destroy_all
          recipe_attrs = @recipe_form.to_attributes
          if @recipe_form.image_uploaded?
            image = Image.create!(@recipe_form.to_image_attributes)
            recipe_attrs.merge(image_id: image.id)
          end
          @recipe.update!(recipe_attrs)
        end
        redirect_to @recipe, notice: 'Recipe was successfully updated.'
      else
        render :edit
      end
    end
    def recipe_form_params
        params.require(:recipe).permit(:title, :description, :image, :ingredients_text, :steps_text, :storage_method, :price, :cooking_time )
    end
end
