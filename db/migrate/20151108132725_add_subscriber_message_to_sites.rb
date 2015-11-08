class AddSubscriberMessageToSites < ActiveRecord::Migration
  def change
    add_column :sites, :subscriber_message, :text
  end
end
