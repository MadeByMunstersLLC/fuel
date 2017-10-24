# frozen_string_literal: true

class Fuel::FaqCategory < ActiveRecord::Base
  has_many :faq_faq_categories, dependent: :destroy
  has_many :faqs, through: :faq_faq_categories

  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name if Rails.version[0].to_i < 4
end
