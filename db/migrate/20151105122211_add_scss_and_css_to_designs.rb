class AddScssAndCssToDesigns < ActiveRecord::Migration
  def change
    add_column :designs, :scss, :text
    add_column :designs, :css, :text
  end
end
