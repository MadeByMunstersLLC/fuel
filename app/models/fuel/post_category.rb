module Fuel
  class PostCategory < ActiveRecord::Base
    belongs_to :category
    has_one :post
  end
end
