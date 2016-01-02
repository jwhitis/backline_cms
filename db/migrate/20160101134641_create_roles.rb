class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, default: "basic", null: false
      t.references :user, null: false, index: true
      t.references :site, null: false, index: true

      t.timestamps null: false
    end
    add_foreign_key :roles, :users
    add_foreign_key :roles, :sites
    add_index :roles, [:user_id, :site_id], unique: true
  end
end
