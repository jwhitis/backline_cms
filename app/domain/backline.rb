module Backline
  class << self
    delegate :reload, to: :site

    def site
      @site ||= Site.first
    end

  end
end