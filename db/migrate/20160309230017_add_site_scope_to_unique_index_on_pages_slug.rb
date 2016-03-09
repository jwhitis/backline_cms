class AddSiteScopeToUniqueIndexOnPagesSlug < ActiveRecord::Migration
  def change
    remove_index :pages, column: :slug, unique: true
    add_index :pages, [:slug, :site_id], unique: true
  end
end
