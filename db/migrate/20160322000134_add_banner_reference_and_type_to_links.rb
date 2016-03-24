class AddBannerReferenceAndTypeToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :banner, index: true
    add_foreign_key :links, :banners
    add_column :links, :type, :string, null: false
  end
end
