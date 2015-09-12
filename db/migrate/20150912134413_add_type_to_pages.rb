class AddTypeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :type, :string, null: false
  end
end
