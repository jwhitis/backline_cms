require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Toddfarrell
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Override default behavior of wrapping fields with errors in DIVs.
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      return html_tag unless html_tag =~ /<(label|input|textarea|select)/

      fragment = Nokogiri::HTML::DocumentFragment.parse(html_tag)
      fragment.children.add_class("field-with-errors")
      fragment.to_s.html_safe
    end

    # Define additional autoload paths.
    config.autoload_paths += %W(#{config.root}/lib/validators)
  end
end
