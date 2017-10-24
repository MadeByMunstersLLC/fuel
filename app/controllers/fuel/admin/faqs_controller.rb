# frozen_string_literal: true

module Fuel
  module Admin
    class FaqsController < AdminController
      layout 'fuel/application'
      before_filter :find_faqs
      before_filter :find_faq, only: %i[edit update destroy]
      before_filter :set_url, only: %i[new create edit update]

      def index; end

      def new
        @faq = Fuel::Faq.new
      end

      def create
        @params_hash = Rails.version[0].to_i < 4 ? params[:fuel_faq] : faq_params
        @faq = Fuel::Faq.new(@params_hash)
        set_category

        if @faq.save
          redirect_to fuel.admin_faqs_path, notice: "Your faq was successfully #{@message}."
        else
          render action: 'new'
        end
      end

      def edit; end

      def update
        @params_hash = Rails.version[0].to_i < 4 ? params[:fuel_faq] : faq_params
        @faq.attributes = @params_hash
        set_category
        if @faq.save
          redirect_to fuel.edit_admin_faq_path(@faq), notice: "Faq was updated and #{@message}"
        else
          render 'edit'
        end
      end

      def destroy
        @faq.destroy
        redirect_to fuel.admin_faqs_path, notice: 'Faq was successfully deleted'
      end

      def show; end

      private

      def faq_params
        params.require(:fuel_faq).permit(:question, :answer, :category)
      end

      def category_params
        params.require(:fuel_faq).permit(:faq_category)[:faq_category]
      end

      def set_category
        if category_params
          @faq.faq_category = Fuel::FaqCategory.find(category_params)
        end
      end

      def find_faq
        @faq = Fuel::Faq.find(params[:id])
      end

      def find_faqs
        @faqs = Fuel::Faq.order('created_at DESC')
      end

      def set_url
        @url = %w[new create].include?(action_name) ? fuel.admin_faqs_path : fuel.admin_faq_path(@faq)
      end
    end
  end
end
