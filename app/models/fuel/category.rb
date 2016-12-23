module Fuel
  class Category < ActiveRecord::Base
    belongs_to :post_category
    has_many :post_category, dependent: :delete_all
    has_many :posts, through: :post_category

    if Rails.version[0].to_i < 4
      attr_accessible :name
    end
  end
end