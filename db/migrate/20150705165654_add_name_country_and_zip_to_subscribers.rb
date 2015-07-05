class AddNameCountryAndZipToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :first_name, :string, null: false
    add_column :subscribers, :last_name, :string, null: false
    add_column :subscribers, :country, :string, null: false
    add_column :subscribers, :zip, :string
  end
end
