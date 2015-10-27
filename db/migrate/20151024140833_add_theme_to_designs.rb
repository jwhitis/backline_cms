class AddThemeToDesigns < ActiveRecord::Migration
  def change
    add_column :designs, :theme, :string, null: false
  end
end
