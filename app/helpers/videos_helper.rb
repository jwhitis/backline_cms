module VideosHelper

  def video_embed_preview video, html_options = {}
    embed = video.embed.try(:dup)
    return "" unless embed.present?

    html_options.each do |attribute, value|
      embed.slice!(/#{attribute}="([^"]*)"/) || embed.slice!(/#{attribute}='([^']*)'/)
      value += " #{$1}" if $1
      embed.sub!("<iframe", "<iframe #{attribute}=\"#{value}\"")
    end

    embed
  end

end