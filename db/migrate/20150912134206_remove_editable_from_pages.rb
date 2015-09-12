class RemoveEditableFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :editable, :boolean, default: true, null: false
  end
end
