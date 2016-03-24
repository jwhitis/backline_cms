class RemoveNullConstraintsFromLinksColumns < ActiveRecord::Migration
  def change
    change_column_null :links, :text,     true
    change_column_null :links, :position, true
    change_column_null :links, :site_id,  true
  end
end
