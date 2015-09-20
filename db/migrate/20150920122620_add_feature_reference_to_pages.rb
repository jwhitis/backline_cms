class AddFeatureReferenceToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :feature, index: true
    add_foreign_key :pages, :features
  end
end
