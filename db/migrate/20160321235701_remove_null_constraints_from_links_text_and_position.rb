class RemoveNullConstraintsFromLinksTextAndPosition < ActiveRecord::Migration
  def change
    change_column_null :links, :text,     true
    change_column_null :links, :position, true
  end
end
