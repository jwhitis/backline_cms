class Snippet
  EXTENSIONS = [:js, :css, :scss]

  attr_reader :name, :body, :extension

  def initialize name, body, extension
    @name      = name
    @body      = body
    @extension = extension
  end

  def self.grouped_by_extension
    EXTENSIONS.each_with_object({}) do |extension, hash|
      hash[extension] = with_extension(extension)
    end
  end

  def self.with_extension extension
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
    File.join(assets_directory, assets_subdirectory(extension), "snippets")
  end

  def self.assets_directory
    File.join(Rails.root, "lib", "assets")
  end

  def self.assets_subdirectory extension
    case extension.to_sym
    when :js
      "javascripts"
    when :css
      "stylesheets"
    when :scss
      "stylesheets"
    end
  end

  def self.name_for file_path
    File.basename(file_path, ".*").titleize
  end

  def self.body_for file_path
    File.read(file_path)
  end

end