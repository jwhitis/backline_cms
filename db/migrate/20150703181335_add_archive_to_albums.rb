class AddArchiveToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :archive, :string
  end
end
