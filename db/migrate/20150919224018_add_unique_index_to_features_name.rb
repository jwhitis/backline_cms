class AddUniqueIndexToFeaturesName < ActiveRecord::Migration
  def change
    add_index :features, :name, unique: true
  end
end
