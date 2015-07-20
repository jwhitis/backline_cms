class Track < ActiveRecord::Base
  include Reorderable

  mount_uploader :audio, AudioUploader

  validates_presence_of :title
end
