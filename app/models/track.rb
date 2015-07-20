class Track < ActiveRecord::Base
  include Orderable

  mount_uploader :audio, AudioUploader

  validates_presence_of :title
end
