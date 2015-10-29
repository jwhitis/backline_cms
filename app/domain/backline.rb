module Backline
  class << self

    def site
      @site ||= Site.first
    end

    def reload
      @site = nil
    end

  end
end