class AddUniqueIndexToPagesTitleAndSlug < ActiveRecord::Migration
  def change
    add_index :pages, :title, unique: true
    add_index :pages, :slug, unique: true
  end
end
