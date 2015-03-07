class AddProfileUrlToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :profile_url, :string
  end
end
