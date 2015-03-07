class RenameProfileImageUrlToImageUrl < ActiveRecord::Migration
  def change
    rename_column :tweets, :profile_image_url, :image_url
  end
end
