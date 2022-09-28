require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HnRuby0722MovieBookingSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Hanoi"
    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = "Hanoi"
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.active_storage.variant_processor = :vips
    config.action_dispatch.rescue_responses.merge!('CanCan::AccessDenied' => :unauthorized)
    config.generators do |g|
      g.test_framework(
        :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        requests: false
      )
    end
  end
end
