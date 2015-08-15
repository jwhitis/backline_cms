class AddScssAndCssToPages < ActiveRecord::Migration
  def change
    add_column :pages, :scss, :text
    add_column :pages, :css, :text
  end
end
