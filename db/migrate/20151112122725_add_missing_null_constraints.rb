class AddMissingNullConstraints < ActiveRecord::Migration
  def change
    change_column_null :photos, :image, false
    change_column_null :photos, :published, false

    change_column_null :shows, :venue_name, false
    change_column_null :shows, :date, false
    change_column_null :shows, :city, false
    change_column_null :shows, :state, false
    change_column_null :shows, :created_at, false
    change_column_null :shows, :updated_at, false
    change_column_null :shows, :published, false

    change_column_null :tweets, :handle, false
    change_column_null :tweets, :image_url, false
    change_column_null :tweets, :text, false
    change_column_null :tweets, :posted_at, false
    change_column_null :tweets, :twitter_id, false
    change_column_null :tweets, :created_at, false
    change_column_null :tweets, :updated_at, false
    change_column_null :tweets, :name, false
    change_column_null :tweets, :profile_url, false

    change_column_null :videos, :title, false
    change_column_null :videos, :embed, false
    change_column_null :videos, :created_at, false
    change_column_null :videos, :updated_at, false
    change_column_null :videos, :published, false
  end
end
