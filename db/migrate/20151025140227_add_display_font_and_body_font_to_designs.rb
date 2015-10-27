class AddDisplayFontAndBodyFontToDesigns < ActiveRecord::Migration
  def change
    add_column :designs, :display_font, :string, null: false
    add_column :designs, :body_font, :string, null: false
  end
end
