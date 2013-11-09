class ChangeShowDateDataType < ActiveRecord::Migration
  def self.up
    change_column :shows, :date, :date
  end

  def self.down
   change_column :shows, :date, :datetime
  end
end
