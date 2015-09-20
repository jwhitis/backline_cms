class AddUniqueIndexToFeatureActivationsFeatureId < ActiveRecord::Migration
  def change
    add_index :feature_activations, [:feature_id, :site_id], unique: true
  end
end
