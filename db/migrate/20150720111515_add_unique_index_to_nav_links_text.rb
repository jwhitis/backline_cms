class AddUniqueIndexToNavLinksText < ActiveRecord::Migration
  def change
    add_index :nav_links, :text, unique: true
  end
end
