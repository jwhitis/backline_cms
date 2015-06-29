class AddDownloadableToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :downloadable, :boolean, default: false, null: false
  end
end
