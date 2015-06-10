class RemoveNullConstraintFromTracksAlbumId < ActiveRecord::Migration
  def change
    change_column_null :tracks, :album_id, true
  end
end
