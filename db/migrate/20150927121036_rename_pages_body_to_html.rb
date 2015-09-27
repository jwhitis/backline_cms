class RenamePagesBodyToHtml < ActiveRecord::Migration
  def change
    rename_column :pages, :body, :html
  end
end
