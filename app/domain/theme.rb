class Theme
  class << self

    def defaults
      @defaults ||= begin
        theme = hashes.first
        theme.last.symbolize_keys.merge(title: theme.first)
      end
    end

    def hashes
      @hashes ||= begin
        raw_themes = File.read(file_path)
        YAML.load(raw_themes)
      end
    end

    def reload
      @defaults = nil
      @hashes = nil
    end

    private

    def file_path
      File.join(Rails.root, "lib", "assets", "themes.yml")
    end

  end
end