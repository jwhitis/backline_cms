class RemoveUniqueIndexFromPagesTitle < ActiveRecord::Migration
  def change
    remove_index :pages, column: :title, unique: true
  end
end
