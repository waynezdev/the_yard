class MilkshakesController < ApplicationController

    before_action :authenticate_user!
    before_action :set_milkshake, only [:show, :edit, :update]

    def index
        if params[:search] && !params[:search].empty?
            @milkshakes = Milkshake.where(name: params[:search])
        else
            @milkshakes = Milkshake.all
        end
    end

    def show
        
    end

    def new

        @milkshake = Milkshake.new
        @ingredients = Ingredient.all

    end

    def create
        
        whitelisted_params = params.require(:milkshake).permit(:name, :description, :price, :pic, ingredient_ids: [])
        # @milkshake = Milkshake.create(whitelisted_params)  is the same as
        # @milkshake = current_user.milkshakes.create(whitelisted_params)
        
        @milkshake = current_user.milkshakes.create(milkshake_params)

        if @milkshake.errors.any?
           @ingredients = Ingredient.all
            render "new"

        else        
            redirect_to milkshake_path(@milkshake)

        end
    end

    def edit
        
        @ingredients = Ingredient.all
    end

    def update

        if @milkshake.update(milkshake_params)
            redirect_to milkshake_math[:id]

        else
            @ingredients = Ingredient.all
            render "edit"

        end

    end

    private
    def milkshake_params

        params.require(:milkshake).permit(:name, :description, :price, :pic, ingredient_ids: [])

    end

    def set_milkshake

        @milkshake = Milkshake.find(params[:id]) 

    end


end