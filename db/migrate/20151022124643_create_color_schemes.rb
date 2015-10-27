class CreateColorSchemes < ActiveRecord::Migration
  def change
    create_table :color_schemes do |t|
      t.string :background, null: false
      t.string :foreground, null: false
      t.string :accent, null: false
      t.string :text, null: false
      t.references :design, index: true

      t.timestamps null: false
    end
    add_foreign_key :color_schemes, :designs
  end
end
