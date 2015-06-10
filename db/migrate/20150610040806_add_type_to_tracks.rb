class AddTypeToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :type, :string, null: false
  end
end
