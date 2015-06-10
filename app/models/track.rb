class Track < ActiveRecord::Base
  validates_presence_of :title

  def self.display_order
    order(:number)
  end

end
