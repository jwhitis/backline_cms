class Snippet
  EXTENSIONS = %w(txt html css scss js)

  attr_reader :title, :content, :extension

  def initialize title, content, extension
    @title     = title
    @content   = content
    @extension = extension
  end

  def self.grouped_by_extension *extensions
    extensions = extensions.any? ? extensions.map(&:to_s) : EXTENSIONS.dup
    grouped_snippets = HashWithIndifferentAccess.new

    extensions.each_with_object(grouped_snippets) do |extension, grouped_snippets|
      snippets = with_extension(extension)
      grouped_snippets[extension] = snippets if snippets.any?
    end
  end

  def self.with_extension extension
    extension = extension.to_s

    if EXTENSIONS.exclude?(extension)
      raise ArgumentError, "#{extension} is not a valid extension."
    end

    file_paths(extension).map do |path|
      Snippet.new(title_for(path), content_for(path), extension)
    end
  end

  private

  def self.file_paths extension
    Dir["#{base_path(extension)}/**/*.#{extension}"]
  end

  def self.base_path extension
    File.join(Rails.root, "lib", "assets", "snippets", extension)
  end

  def self.title_for file_path
    File.basename(file_path, ".*").titleize
  end

  def self.content_for file_path
    File.read(file_path)
  end

end