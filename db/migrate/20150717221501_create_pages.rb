class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body
      t.string :image
      t.text :video_embed
      t.boolean :published, default: false, null: false

      t.timestamps null: false
    end
  end
end
