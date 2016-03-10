class Track < ActiveRecord::Base
  include SiteScope
  include Orderable

  mount_uploader :audio, AudioUploader

  validates_presence_of :title

  alias_attribute :number, :position
end
