class RenameScreenNameToHandle < ActiveRecord::Migration
  def change
    rename_column :tweets, :screen_name, :handle
  end
end
