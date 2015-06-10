class RenameAlbumTracksToTracks < ActiveRecord::Migration
  def change
    rename_table :album_tracks, :tracks
  end
end
