class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :caption
      t.text :embed

      t.timestamps
    end
  end
end
