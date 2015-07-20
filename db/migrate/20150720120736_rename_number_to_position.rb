class RenameNumberToPosition < ActiveRecord::Migration
  def change
    rename_column :tracks, :number, :position
    rename_column :nav_links, :number, :position
  end
end
