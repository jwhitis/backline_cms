class Admin::AlbumTracksController < Admin::AdminController
  before_action :find_album
  respond_to :js

  def index
    @album_track = AlbumTrack.new
    @album_tracks = @album.tracks.display_order
  end

  def create
    @album_track = @album.tracks.new(album_track_params)

    if @album_track.save
      @album_track = AlbumTrack.new
      flash.now[:notice] = "Track successfully added."
    end

    @album_tracks = @album.tracks.display_order
    render :index
  end

  def destroy
    @album_track = @album.tracks.find(params[:id])
    @album_track.destroy
    @album_track = AlbumTrack.new
    @album_tracks = @album.tracks.display_order
    flash.now[:notice] = "Track successfully removed."
    render :index
  end

  private

  def find_album
    @album = Album.find(params[:album_id])
  end

  def album_track_params
    params.require(:album_track).permit(:title, :audio, :audio_cache)
  end

end