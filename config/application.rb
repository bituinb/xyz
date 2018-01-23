require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Xyz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = "UTC"
    config.active_job.queue_adapter = :resque
    config.active_job.queue_name_prefix = "#{Rails.env}.new-lms-test"
    config.active_job.queue_name_delimiter = '.'
    config.action_mailer.deliver_later_queue_name = "mailers"
    config.scheduled_job_queue_name = "#{Rails.application.config.active_job.queue_name_prefix}.scheduled_job"
  end
end
