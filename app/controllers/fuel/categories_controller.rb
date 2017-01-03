module Fuel
  class CategoriesController < FuelController
    def index
      @categories = Fuel::Category.all

      respond_to do |format|
        format.json { render json: @categories, includes: [:posts] }
      end
    end
  end
end
