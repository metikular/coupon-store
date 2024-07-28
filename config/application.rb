require_relative "boot"

require "rails/all"

require "barby/barcode/ean_13"
require "barby/barcode/code_25_interleaved"
require "barby/barcode/code_25_iata"
require "barby/barcode/code_39"
require "barby/barcode/code_93"
require "barby/barcode/code_128"
require "barby/barcode/bookland"
require "barby/barcode/ean_8"
require "barby/barcode/upc_supplemental"
require "barby/barcode/qr_code"

require "barby/outputter/svg_outputter"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CouponStore
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.generators do |g|
      g.template_engine :haml
    end

    I18n.available_locales = %i[en]
    I18n.default_locale = :en

    config.action_mailer.default_url_options = {
      host: ENV.fetch("HOST", "localhost"),
      port: 443,
      protocol: :https
    }
    config.action_controller.default_url_options = config.action_mailer.default_url_options
  end
end
