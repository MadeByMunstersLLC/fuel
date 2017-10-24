# frozen_string_literal: true

module Fuel
  module Admin
    class FaqCategoriesController < AdminController
      layout 'fuel/application'
      before_filter :find_faq_categories
      before_filter :find_faq_category, only: %i[edit update destroy show]
      before_filter :set_url, only: %i[new create edit update]

      def index; end

      def new
        @faq_category = Fuel::FaqCategory.new
      end

      def create
        @params_hash = Rails.version[0].to_i < 4 ? params[:fuel_faq_category] : faq_category_params

        @faq_category = Fuel::FaqCategory.new(@params_hash)

        if @faq_category.save
          redirect_to fuel.admin_faq_categories_path, notice: "Your faq_category was successfully #{@message}."
        else
          render action: 'new'
        end
      end

      def edit; end

      def update
        @params_hash = Rails.version[0].to_i < 4 ? params[:fuel_faq_category] : faq_category_params

        @faq_category.attributes = @params_hash
        @faq_category.slug = nil
        if @faq_category.save
          redirect_to fuel.edit_admin_faq_category_path(@faq_category), notice: "Faq Category was updated and #{@message}"
        else
          render action: 'edit'
        end
      end

      def destroy
        @faq_category.destroy
        redirect_to fuel.admin_faq_categories_path, notice: 'Faq Category was successfully deleted'
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

      def find_faq_categories
        @faq_categories = Fuel::FaqCategory.order('created_at ASC')
      end

      def faq_category_params
        params.require(:fuel_faq_category).permit(:name)
      end

      def set_url
        @url = %w[new create].include?(action_name) ? fuel.admin_faq_categories_path : fuel.admin_faq_category_path(@faq_category)
      end
    end
  end
end
