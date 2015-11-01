module VideosHelper

  def video_embed_preview video, html_options = {}
    embed = video.embed.try(:dup)

    unless embed.present?
      return image_tag asset_path("default_image.png"), html_options
    end

    html_options.each do |attribute, value|
      embed.slice!(/#{attribute}="([^"]*)"/) || embed.slice!(/#{attribute}='([^']*)'/)
      value += " #{$1}" if $1
      embed.sub!("<iframe", "<iframe #{attribute}=\"#{value}\"")
    end

    embed
  end

end