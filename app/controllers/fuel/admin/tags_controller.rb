module Fuel
  module Admin
    class TagsController < AdminController
      layout "fuel/application"
      before_filter :find_tags
      before_filter :find_tag, only: [:edit, :update, :destroy]
      before_filter :set_url, only: [:new, :create, :edit, :update]

      def index
      end

      def new
        @tag = Fuel::Tag.new
      end

      def create
        @params_hash = Rails.version[0].to_i < 4 ? params[:fuel_tag] : tag_params

        @tag = Fuel::Tag.new(@params_hash)

        if @tag.save
          redirect_to fuel.admin_tags_path, notice: "Your tag was successfully #{@message}."
        else
          render action: "new"
        end
      end

      def edit

      end

      def update
        @params_hash = Rails.version[0].to_i < 4 ? params[:fuel_tag] : tag_params

        @tag.attributes = @params_hash

        if @tag.save
          redirect_to fuel.edit_admin_tag_path(@tag), notice: "tag was updated and #{@message}"
        else
          render action: "edit"
        end
      end

      def destroy
        @tag.destroy
        redirect_to fuel.admin_tags_path, notice: "Tag was successfully deleted"
      end

      def show
        @author = Fuel::Tag.find(params[:id])

        respond_to do |format|
          format.json { render json: @author }
        end
      end

      private
        def find_tag
          @tag = Fuel::Tag.find_by_id(params[:id])
        end

        def find_tags
          @tags = Fuel::Tag.order("created_at ASC")
        end

        def tag_params
          params.require(:fuel_tag).permit(:name)
        end

        def set_url
          @url = ["new", "create"].include?(action_name) ? fuel.admin_tags_path : fuel.admin_tag_path(@tag)
        end
    end
  end
end
