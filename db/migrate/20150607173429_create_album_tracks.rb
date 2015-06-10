class CreateAlbumTracks < ActiveRecord::Migration
  def change
    create_table :album_tracks do |t|
      t.string :title, null: false
      t.integer :number, null: false
      t.references :album, null: false, index: true

      t.timestamps null: false
    end
    add_foreign_key :album_tracks, :albums
  end
end
