class RenameVenueToVenueName < ActiveRecord::Migration
  def change
    rename_column :shows, :venue, :venue_name
  end
end
