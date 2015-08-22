class RemoveNullConstraintsFromSubscribers < ActiveRecord::Migration
  def change
    change_column_null :subscribers, :first_name, true
    change_column_null :subscribers, :last_name, true
    change_column_null :subscribers, :country, true
  end
end
