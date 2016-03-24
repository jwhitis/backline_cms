class RenameNavLinksToLinks < ActiveRecord::Migration
  def change
    rename_table :nav_links, :links
  end
end
