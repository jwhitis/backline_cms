class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.references :homepage, null: false, index: true

      t.timestamps null: false
    end
    add_foreign_key :configurations, :pages, column: :homepage_id
  end
end
