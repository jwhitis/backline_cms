class AddDefaultsToPublishedColumns < ActiveRecord::Migration
  def change
    change_column_default :photos, :published, false
    change_column_default :shows, :published, false
    change_column_default :videos, :published, false
  end
end
