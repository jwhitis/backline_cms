class Admin::AlbumTracksController < Admin::AdminController
  before_action :find_album
  before_action :find_album_track, only: [:edit, :update, :destroy]
  respond_to :js

  def index
    @album_tracks = @album.tracks.display_order
  end

  def new
    @album_track = AlbumTrack.new
  end

  def create
    @album_track = @album.tracks.new(album_track_params)

    if @album_track.save
      @album_tracks = @album.tracks.display_order
      flash.now[:notice] = "Track successfully added."
      render :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @album_track.update_attributes(album_track_params)
      @album_tracks = @album.tracks.display_order
      flash.now[:notice] = "Track successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @album_track.destroy
    @album_track = AlbumTrack.new
    @album_tracks = @album.tracks.display_order
    flash.now[:notice] = "Track successfully removed."
    render :index
  end

  def reorder
    AlbumTrack.reorder!(params[:resource_ids], album: @album)
    @album_track = AlbumTrack.new
    @album_tracks = @album.tracks.display_order
    render :index
  end

  def download
  end

  private

  def find_album
    @album = Album.find(params[:album_id])
  end

  def find_album_track
    @album_track = @album.tracks.find(params[:id])
  end

  def album_track_params
    params.require(:album_track).permit(:title, :audio, :audio_cache, :remove_audio, :downloadable)
  end

end