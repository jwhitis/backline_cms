class RenameConfigurationsToSites < ActiveRecord::Migration
  def change
    rename_table :configurations, :sites
  end
end
