class CreateTwitterHandles < ActiveRecord::Migration
  def change
    create_table :twitter_handles do |t|
      t.string :handle, null: false

      t.timestamps null: false
    end
  end
end
