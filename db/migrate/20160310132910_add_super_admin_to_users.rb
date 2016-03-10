class AddSuperAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :super_admin, :boolean, default: false, null: false
  end
end
