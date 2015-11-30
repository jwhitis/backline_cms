class AddExclusiveContentToPages < ActiveRecord::Migration
  def change
    add_column :pages, :exclusive_content, :boolean, default: false, null: false
  end
end
