class Track < ActiveRecord::Base
  include Reorderable

  mount_uploader :audio, AudioUploader

  validates_presence_of :title

  def self.display_order
    order(:number)
  end

end
