# This migration comes from fuel (originally 20170103220715)
class AddFriendlyIdToTagsAndCategories < ActiveRecord::Migration
  def up
    # Create columns
    add_column :fuel_categories, :slug, :string
    add_column :fuel_categories, :posts_count, :integer, default: 0
    add_column :fuel_tags, :slug, :string

    # Add not-null constraints
    change_column_null :fuel_categories, :slug, false
    change_column_null :fuel_tags, :slug, false

    # Add uniqueness-guaranteeing indexes over the new slug columns
    add_index :fuel_categories, :slug, unique: true
    add_index :fuel_tags, :slug, unique: true
  end

  def down
    # Remove indexes first (not technically necessary, but it feels cleaner)
    remove_index :fuel_categories, :slug
    remove_index :fuel_tags, :slug

    # Remove columns
    remove_column :fuel_categories, :slug
    remove_column :fuel_categories, :posts_count
    remove_column :fuel_tags, :slug
  end
end
