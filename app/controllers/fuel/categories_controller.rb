# frozen_string_literal: true

module Fuel
  class CategoriesController < FuelController
    before_action :find_category, only: [:show]

    def index
      @categories = Fuel::Category.all

      respond_to do |format|
        format.json { render json: @categories }
      end
    end

    def show
      respond_to do |format|
        format.json { render json: @category }
      end
    end

    private

    def find_category
      @category = Fuel::Category.find_by_slug(params[:slug])
    end
  end
end
