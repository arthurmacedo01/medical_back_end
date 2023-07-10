require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MedicalBackEnd
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.active_job.queue_adapter = :delayed_job

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    Aws.config.update(
      region: "us-east-1",
      credentials:
        Aws::Credentials.new(
          Rails.application.credentials.dig(:aws, :access_key_id),
          Rails.application.credentials.dig(:aws, :secret_access_key),
        ),
    )
  end
end
