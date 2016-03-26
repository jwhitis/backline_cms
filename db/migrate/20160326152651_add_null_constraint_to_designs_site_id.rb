class AddNullConstraintToDesignsSiteId < ActiveRecord::Migration
  def change
    change_column_null :designs, :site_id, false
  end
end
