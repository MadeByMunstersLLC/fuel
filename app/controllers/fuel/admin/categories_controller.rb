module Fuel
  module Admin
    class CategoriesController < AdminController
      layout "fuel/application"
      before_filter :find_categories
      before_filter :find_category, only: [:edit, :update, :destroy]
      before_filter :set_url, only: [:new, :create, :edit, :update]

      def index
      end

      def new
        @category = Fuel::Category.new
      end

      def create
        @params_hash = Rails.version[0].to_i < 4 ? params[:fuel_category] : category_params

        @category = Fuel::Category.new(@params_hash)

        if @category.save
          redirect_to fuel.admin_categories_path, notice: "Your category was successfully #{@message}."
        else
          render action: "new"
        end
      end

      def edit

      end

      def update
        @params_hash = Rails.version[0].to_i < 4 ? params[:fuel_category] : category_params

        @category.attributes = @params_hash
        @category.slug = nil
        if @category.save
          redirect_to fuel.edit_admin_category_path(@category), notice: "Category was updated and #{@message}"
        else
          render action: "edit"
        end
      end

      def destroy
        @category.posts.each do |post|
          post.category = nil
          post.save
        end
        
        @category.destroy
        redirect_to fuel.admin_categories_path, notice: "Category was successfully deleted"
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

        def find_categories
          @categories = Fuel::Category.order("created_at ASC")
        end

        def category_params
          params.require(:fuel_category).permit(:name)
        end

        def set_url
          @url = ["new", "create"].include?(action_name) ? fuel.admin_categories_path : fuel.admin_category_path(@category)
        end
    end
  end
end
