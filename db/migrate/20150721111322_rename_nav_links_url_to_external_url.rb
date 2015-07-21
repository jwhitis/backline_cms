class RenameNavLinksUrlToExternalUrl < ActiveRecord::Migration
  def change
    rename_column :nav_links, :url, :external_url
    change_column_null :nav_links, :external_url, true
  end
end
