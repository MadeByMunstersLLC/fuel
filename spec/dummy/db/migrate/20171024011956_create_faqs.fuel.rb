# This migration comes from fuel (originally 20171023230731)
class CreateFaqs < ActiveRecord::Migration
  def up
    create_table :fuel_faqs do |t|
      t.text :question
      t.text :answer
      t.timestamps null: false
    end

    create_table :fuel_faq_categories do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    create_table :fuel_faq_faq_categories do |t|
      t.references :faq
      t.references :faq_category
      t.timestamps null: false
    end

    add_column :fuel_faq_categories, :slug, :string
    add_index :fuel_faq_categories, :slug, unique: true
  end

  def down
    # Nicely destroy all existing models
    Fuel::FaqCategory.all.each(&:destroy)
    Fuel::Faq.all.each(&:destroy)

    drop_table :fuel_faqs
    drop_table :fuel_faq_categories
    drop_table :fuel_faq_faq_categories

    remove_column :fuel_faq_categories, :slug
    remove_index :fuel_faq_categories, :slug
  end
end
