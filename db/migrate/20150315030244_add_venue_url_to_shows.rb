class AddVenueUrlToShows < ActiveRecord::Migration
  def change
    add_column :shows, :venue_url, :string
  end
end
