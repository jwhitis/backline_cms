class UpdateColorSchemesColumns < ActiveRecord::Migration
  def change
    remove_column :color_schemes, :background, :string, null: false
    remove_column :color_schemes, :foreground, :string, null: false
    remove_column :color_schemes, :accent,     :string, null: false
    remove_column :color_schemes, :text,       :string, null: false

    add_column :color_schemes, :nav_background,    :string, null: false
    add_column :color_schemes, :nav_text,          :string, null: false
    add_column :color_schemes, :main_background,   :string, null: false
    add_column :color_schemes, :main_text,         :string, null: false
    add_column :color_schemes, :footer_background, :string, null: false
    add_column :color_schemes, :footer_text,       :string, null: false
    add_column :color_schemes, :button_background, :string, null: false
    add_column :color_schemes, :button_text,       :string, null: false
  end
end
