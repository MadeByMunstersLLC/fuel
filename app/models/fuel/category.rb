module Fuel
  class Category < ActiveRecord::Base
    has_many :posts

    extend FriendlyId
    friendly_id :name, use: :slugged

    if Rails.version[0].to_i < 4
      attr_accessible :name
    end
  end
end