class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :venue
      t.datetime :date
      t.string :cover
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.text :notes

      t.timestamps
    end
  end
end
