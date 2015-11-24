class ChangeTweetsTwitterIdTypeToInteger < ActiveRecord::Migration
  def up
    rename_column :tweets, :twitter_id, :twitter_id_string
    add_column :tweets, :twitter_id, :integer, limit: 8

    Tweet.all.each do |tweet|
      tweet.update_attributes!(twitter_id: tweet.twitter_id_string)
    end

    change_column_null :tweets, :twitter_id, false
    remove_column :tweets, :twitter_id_string
  end

  def down
    rename_column :tweets, :twitter_id, :twitter_id_integer
    add_column :tweets, :twitter_id, :string

    Tweet.all.each do |tweet|
      tweet.update_attributes!(twitter_id: tweet.twitter_id_integer)
    end

    change_column_null :tweets, :twitter_id, false
    remove_column :tweets, :twitter_id_integer
  end
end
