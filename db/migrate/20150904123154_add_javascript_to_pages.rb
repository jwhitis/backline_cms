class AddJavascriptToPages < ActiveRecord::Migration
  def change
    add_column :pages, :javascript, :text
  end
end
