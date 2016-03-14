class RemovePageForeignKeysFromSites < ActiveRecord::Migration
  def up
    remove_foreign_key :sites, column: :home_page_id
    remove_foreign_key :sites, column: :splash_page_id
  end

  def down
    add_foreign_key :sites, :pages, column: :home_page_id
    add_foreign_key :sites, :pages, column: :splash_page_id
  end
end
