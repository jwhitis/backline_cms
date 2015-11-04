class AddSplashPageReferenceToSites < ActiveRecord::Migration
  def change
    add_reference :sites, :splash_page, index: true
    add_foreign_key :sites, :pages, column: :splash_page_id
  end
end
