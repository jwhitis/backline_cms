class AddUniqueIndexToSubscribersEmail < ActiveRecord::Migration
  def change
    add_index :subscribers, :email, unique: true
  end
end
