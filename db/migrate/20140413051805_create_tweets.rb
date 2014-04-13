class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :screen_name
      t.string :profile_image_url
      t.text :text
      t.datetime :posted_at
      t.column :twitter_id, :bigint

      t.timestamps
    end
  end
end
