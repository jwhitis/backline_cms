class CreateNavLinks < ActiveRecord::Migration
  def change
    create_table :nav_links do |t|
      t.string :text, null: false
      t.string :url, null: false
      t.integer :number, null: false
      t.references :page, index: true

      t.timestamps null: false
    end
    add_foreign_key :nav_links, :pages
  end
end
