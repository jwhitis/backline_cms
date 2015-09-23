class AlbumsController < ApplicationController
  before_action :verify_user_subscribed!, only: :download

  def index
    @albums = Album.published.display_order.includes(:tracks)
    respond_to :html, :js
  end

  def download
    @album = Album.find(params[:id])
    return head(:forbidden) unless @album.downloadable?

    data = open(@album.archive.url)
    send_data data.read, filename: filename, type: file_type
  end

  private

  def filename
    filename = @album.title.parameterize.underscore
    "#{filename}.#{extension}"
  end

  def extension
    @album.archive.file.extension
  end

  def file_type
    @album.archive.content_type
  end

end