class AddTitleAndDescriptionToSites < ActiveRecord::Migration
  def change
    add_column :sites, :title, :string, null: false
    add_column :sites, :description, :text
  end
end
