class AlbumTracksController < ApplicationController
  before_action :verify_feature_active!
  before_action :verify_subscriber_exists!, only: :download
  feature_name :albums

  def download
    @album_track = AlbumTrack.downloadable.find(params[:id])
    data = open(@album_track.audio.url)
    send_data data.read, filename: filename, type: file_type
  end

  private

  def filename
    filename = @album_track.title.parameterize.underscore
    "#{filename}.#{extension}"
  end

  def extension
    @album_track.audio.file.extension
  end

  def file_type
    @album_track.audio.content_type
  end

end