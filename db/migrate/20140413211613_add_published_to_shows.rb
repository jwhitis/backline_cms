class AddPublishedToShows < ActiveRecord::Migration
  def change
    add_column :shows, :published, :boolean
  end
end
