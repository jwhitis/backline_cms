class AddEditableToPages < ActiveRecord::Migration
  def change
    add_column :pages, :editable, :boolean, default: true, null: false
  end
end
