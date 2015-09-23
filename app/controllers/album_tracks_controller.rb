class AlbumTracksController < ApplicationController
  before_action :verify_feature_activated!
  before_action :verify_user_subscribed!, only: :download

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

  def feature_name
    "Music"
  end

end