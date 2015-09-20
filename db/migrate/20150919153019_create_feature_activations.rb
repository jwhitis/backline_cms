class CreateFeatureActivations < ActiveRecord::Migration
  def change
    create_table :feature_activations do |t|
      t.references :site, index: true, null: false
      t.references :feature, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :feature_activations, :sites
    add_foreign_key :feature_activations, :features
  end
end
