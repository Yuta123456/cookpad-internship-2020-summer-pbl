class RecipesController < ApplicationController
    def show
        @recipe = Recipe.find(params[:id])
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
    def recipe_form_params
        params.require(:recipe).permit(:title, :description, :image, :ingredients_text, :steps_text, :storage_method, :price, :cooking_time )
    end
end
