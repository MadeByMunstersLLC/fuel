class AddFriendlyIdToTagsAndCategories < ActiveRecord::Migration
  def up
    add_column :fuel_tags, :slug, :string
    add_column :fuel_categories, :slug, :string
    add_column :fuel_categories, :posts_count, :integer, default: 0
  end

  def down
    remove_column :fuel_tags, :slug
    remove_column :fuel_categories, :slug
    remove_column :fuel_categories, :posts_count
  end
end
