class Snippet
  EXTENSIONS = %w(js css scss html)

  attr_reader :name, :body, :extension

  def initialize name, body, extension
    @name      = name
    @body      = body
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
      Snippet.new(name_for(path), body_for(path), extension)
    end
  end

  private

  def self.file_paths extension
    Dir["#{base_path(extension)}/**/*.#{extension}"]
  end

  def self.base_path extension
    File.join(Rails.root, "lib", "assets", "snippets", extension)
  end

  def self.name_for file_path
    File.basename(file_path, ".*").titleize
  end

  def self.body_for file_path
    File.read(file_path)
  end

end