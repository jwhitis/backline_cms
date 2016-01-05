class RemoveNullConstraintFromSitesHomePageId < ActiveRecord::Migration
  def change
    change_column_null :sites, :home_page_id, true
  end
end
