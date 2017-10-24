# frozen_string_literal: true

module Fuel
  class FaqCategoriesController < FuelController
    before_action :find_faq_category, only: [:show]

    def index
      @faq_categories = Fuel::FaqCategory.all

      respond_to do |format|
        format.json { render json: @faq_categories.as_json(only: %i[id name], include: [:faqs]) }
      end
    end

    def show
      respond_to do |format|
        format.json { render json: @faq_category }
      end
    end

    private

    def find_faq_category
      @faq_category = Fuel::FaqCategory.find_by_slug(params[:slug])
    end
  end
end
