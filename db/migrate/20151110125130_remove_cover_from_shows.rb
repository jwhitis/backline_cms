class RemoveCoverFromShows < ActiveRecord::Migration
  def change
    remove_column :shows, :cover, :string
  end
end
