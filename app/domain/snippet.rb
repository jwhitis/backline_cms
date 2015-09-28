class Snippet
  EXTENSIONS = %w(txt html css scss js)

  attr_reader :title, :contents, :extension

  def initialize title, contents, extension
    @title     = title
    @contents  = contents
    @extension = extension
  end

  def self.grouped_by_extension
    snippets_hash = HashWithIndifferentAccess.new

    EXTENSIONS.each_with_object(snippets_hash) do |extension, hash|
      hash[extension] = with_extension(extension)
    end
  end

  def self.with_extension extension
    extension = extension.to_s

    if EXTENSIONS.exclude?(extension)
      raise ArgumentError, "#{extension} is not a valid extension."
    end

    file_paths(extension).map do |path|
      Snippet.new(title_for(path), contents_for(path), extension)
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

  def self.contents_for file_path
    File.read(file_path)
  end

end