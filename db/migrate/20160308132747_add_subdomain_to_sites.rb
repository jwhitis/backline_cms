class AddSubdomainToSites < ActiveRecord::Migration
  def change
    add_column :sites, :subdomain, :string, null: false
    add_index :sites, :subdomain, unique: true
  end
end
