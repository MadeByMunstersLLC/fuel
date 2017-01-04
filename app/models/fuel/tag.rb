module Fuel
  class Tag < ActiveRecord::Base
    has_many :post_tags, dependent: :destroy
    has_many :posts, through: :post_tags

    extend FriendlyId
    friendly_id :name, use: :slugged

    if Rails.version[0].to_i < 4
      attr_accessible :name
    end
  end
end