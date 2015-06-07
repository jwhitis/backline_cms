class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.date :release_date, null: false
      t.text :notes
      t.string :bandcamp_url
      t.string :itunes_url
      t.string :cover_art, null: false
      t.boolean :published, default: false, null: false

      t.timestamps null: false
    end
  end
end
