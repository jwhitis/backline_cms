class AddSiteScopeToUniqueIndexOnNavLinksText < ActiveRecord::Migration
  def change
    remove_index :nav_links, column: :text, unique: true
    add_index :nav_links, [:text, :site_id], unique: true
  end
end
