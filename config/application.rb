require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Devices
  class Application < Rails::Application
    config.load_defaults 5.1
    config.middleware.use Rack::JWT::Auth, secret: secrets.secret_key_base, exclude: %w(/api/users /users)
  end
end
