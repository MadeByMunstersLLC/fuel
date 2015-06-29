module Fuel
  class Post < ActiveRecord::Base
    include ActionView::Helpers::OutputSafetyHelper

    extend FriendlyId
    friendly_id :title, use: :slugged

    belongs_to :author

    if Rails.version[0].to_i < 4
      attr_accessible :tag, :author_id, :content, :title, :teaser, :featured_image, :seo_title, :seo_description, :published_at
    end

    # if Fuel.configuration.aws_bucket
      has_attached_file :featured_image, :styles => { :medium => Fuel.configuration.featured_image_settings[:styles][:medium], :thumb => Fuel.configuration.featured_image_settings[:styles][:thumb] }, :default_url => "fuel/default-img.jpg", :storage => :s3, :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
    # else
      # has_attached_file :featured_image, :styles => { :medium => Fuel.configuration.featured_image_settings[:styles][:medium], :thumb => Fuel.configuration.featured_image_settings[:styles][:thumb] }, :default_url => "fuel/default-img.jpg"
    # end
    validates_attachment_content_type :featured_image, :content_type => /\Aimage\/.*\Z/

    validates_presence_of :title, :content, :author_id, if: :is_published
    paginates_per Fuel.configuration.paginates_per.to_i

    scope :recent_published_posts, -> { where(published: true).order("created_at DESC") }
    scope :recent, -> { order("created_at DESC") }

    def s3_credentials
      {:bucket => Fuel.configuration.aws_bucket, :access_key_id => Fuel.configuration.aws_access_key, :secret_access_key => Fuel.configuration.aws_secret_access_key}
    end

    def next
      self.class.recent.where("created_at <= ? AND id != ?", created_at, id).first
    end

    def previous
      self.class.recent.where("created_at >= ? AND id != ?", created_at, id).last
    end

    def should_generate_new_friendly_id?
      new_record? #Don't generate new id on edit
    end

    def save_as_draft
      self.published = false
    end

    def is_published
      self.published
    end

    def prioritized_featured_image_url(type = :original)
      featured_image_file_name.present? ? featured_image.url(type) : featured_image_url
    end

    def teaser_content
      teaser.present? ? teaser : content
    end

    def to_html
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
          :autolink => true, :space_after_headers => true)
      raw markdown.render(content)
    end

  end
end
