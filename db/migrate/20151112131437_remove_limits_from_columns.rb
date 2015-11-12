class RemoveLimitsFromColumns < ActiveRecord::Migration
  def change
    change_column :shows, :venue_name, :string, limit: nil
    change_column :shows, :address, :string, limit: nil
    change_column :shows, :city, :string, limit: nil
    change_column :shows, :state, :string, limit: nil
    change_column :shows, :zip, :string, limit: nil
    change_column :shows, :time, :string, limit: nil

    change_column :tweets, :handle, :string, limit: nil
    change_column :tweets, :image_url, :string, limit: nil
    change_column :tweets, :twitter_id, :string, limit: nil

    change_column :videos, :title, :string, limit: nil
  end
end
