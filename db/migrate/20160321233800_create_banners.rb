class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :image, null: false
      t.boolean :full_screen, default: false, null: false
      t.references :design, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :banners, :designs
  end
end
