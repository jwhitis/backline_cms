module AlbumsHelper

  def streamable_tracks? album
    value = instance_variable_get("@streamable_#{album.id}")
    return value unless value.nil?

    instance_variable_set("@streamable_#{album.id}", album.tracks.streamable.exists?)
  end

end