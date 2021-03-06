module Fuel
  class PostsController < FuelController
    include ActionView::Helpers::TextHelper
    layout Fuel.configuration.layout if Fuel.configuration.layout
    before_filter :define_title
    paginated_action only: [:index]

    def define_title
      @blog_title = Fuel.configuration.blog_title
    end

    def index
      @posts = Fuel::Post.recent_published_posts.page(@pagination_current_page).per(@pagination_per_page)
      @title = Fuel.configuration.blog_title
      @description = Fuel.configuration.blog_description

      respond_to do |format|
        format.html
        format.json { render json: @posts, :methods => [:avatar_url, :featured_image_url] }
      end
    end

    def show
      @post = Fuel::Post.find_by_slug(params[:id]) || Fuel::Post.find_by_id(params[:id]) || not_found
      @title = truncate_on_space(@post.seo_title || @post.title, 70)
      @description = @post.seo_description
      @disqus_name = Fuel.configuration.disqus_name

      respond_to do |format|
        format.html
        format.json { render json: @post, :methods => [:avatar_url, :featured_image_url] }
      end
    end

    def preview
      @content = params[:content]
      respond_to do |format|
        format.js
      end
    end

    def redirect
      post = Fuel::Post.find_by_slug(params[:id]) || Fuel::Post.find_by_id(params[:id])
      return redirect_to fuel.post_path(post)
    end

    private

      def truncate_on_space(text = "", length)
        truncate(text, length: length, separator: ' ')
      end

  end
end
