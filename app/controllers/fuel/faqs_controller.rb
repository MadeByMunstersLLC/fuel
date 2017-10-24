module Fuel
  class FaqsController < FuelController
    before_action :find_category, only: [:show]

    def index
      @faqs = Fuel::Faq.all

      respond_to do |format|
        format.json { render json: @faqs.as_json(include: [faq_category: {only: [:name, :id]}]) }
      end
    end

    def show
      respond_to do |format|
        format.json { render json: @faq }
      end
    end

  private

    def find_category
      @faq = Fuel::Faq.find_by_slug(params[:id])
    end
  end
end
