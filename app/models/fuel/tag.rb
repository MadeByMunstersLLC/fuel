module Fuel
  class Tag < ActiveRecord::Base
    has_many :post_tags, dependent: :delete_all
    has_many :posts, through: :post_tags

    if Rails.version[0].to_i < 4
      attr_accessible :name
    end
  end
end