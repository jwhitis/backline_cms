class AddStandaloneToPages < ActiveRecord::Migration
  def change
    add_column :pages, :standalone, :boolean, default: false, null: false
  end
end
