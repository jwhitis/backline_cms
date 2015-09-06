module Backline
  class << self
    delegate :reload, to: :configuration

    def configuration
      @configuration ||= Configuration.first
    end

  end
end