module Fuel
  class Category < ActiveRecord::Base
    has_many :posts

    if Rails.version[0].to_i < 4
      attr_accessible :name
    end
  end
end