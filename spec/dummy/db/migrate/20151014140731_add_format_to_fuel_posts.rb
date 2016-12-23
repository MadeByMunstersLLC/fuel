# This migration comes from fuel (originally 20151014140731)
class AddFormatToFuelPosts < ActiveRecord::Migration
  def change
    add_column :fuel_posts, :format, :string, default: "html"
  end
end
