class AddTicketsUrlToShows < ActiveRecord::Migration
  def change
    add_column :shows, :tickets_url, :string
  end
end
