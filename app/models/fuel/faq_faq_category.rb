# frozen_string_literal: true

class Fuel::FaqFaqCategory < ActiveRecord::Base
  belongs_to :faq
  belongs_to :faq_category
end
