require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyRailsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Load presenters
    config.after_initialize do |app|
      app.config.paths.add 'app/presenters', :eager_load => true
    end

    # Load Enviroment Variables
    config.before_configuration do
      env_file_name = (Rails.env == 'test' ? 'local_env.yml.sample' : 'local_env.yml')
      env_file = File.join(Rails.root, 'config', env_file_name)

      if File.exists?(env_file)
        env_variables = YAML.load(File.open(env_file))[Rails.env]

        if env_variables.present?
          env_variables.each do
            |key, value| ENV[key.to_s] = value
          end
        end
      end
    end
  end
end
