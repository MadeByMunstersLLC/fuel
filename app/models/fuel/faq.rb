# frozen_string_literal: true

class Fuel::Faq < ActiveRecord::Base
  has_one :faq_faq_category, dependent: :destroy
  has_one :faq_category, through: :faq_faq_category
end
