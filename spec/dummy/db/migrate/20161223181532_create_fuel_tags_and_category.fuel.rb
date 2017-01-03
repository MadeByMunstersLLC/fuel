# This migration comes from fuel (originally 20161222211605)
class CreateFuelTagsAndCategory < ActiveRecord::Migration
  def up
    create_table :fuel_tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :fuel_categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :fuel_post_tags do |t|
      t.references :post
      t.references :tag
      t.timestamps
    end

    remove_column :fuel_posts, :tag
    add_reference :fuel_posts, :category, foreign_key: true
  end

  def down
    # Nicely destroy all existing models
    Fuel::Tag.all.each(&:destroy)
    Fuel::Category.all.each(&:destroy)

    drop_table :fuel_tags
    drop_table :fuel_categories
    drop_table :fuel_post_tags

    add_column :fuel_posts, :tag, :string
    remove_reference :fuel_posts, :category
  end
end
