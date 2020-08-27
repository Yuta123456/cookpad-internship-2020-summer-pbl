class TopController < ApplicationController
    def index
        @recipes = Recipe.order(id: :desc).limit(4)
    end
end
