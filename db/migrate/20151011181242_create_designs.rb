class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.string :background_image
      t.string :banner_image
      t.string :logo
      t.string :favicon
      t.references :site, index: true

      t.timestamps null: false
    end
    add_foreign_key :designs, :sites
  end
end
