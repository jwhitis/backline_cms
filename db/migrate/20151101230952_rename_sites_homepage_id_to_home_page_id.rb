class RenameSitesHomepageIdToHomePageId < ActiveRecord::Migration
  def change
    rename_column :sites, :homepage_id, :home_page_id
  end
end
