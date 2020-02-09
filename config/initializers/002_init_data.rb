# frozen_string_literal: true

APP_CONFIG = YAML.safe_load(File.read(File.expand_path('../app_config.yml', __dir__))).fetch(Rails.env)
CONTACT_CONFIG = YAML.safe_load(File.read(File.expand_path('../contacts.yml', __dir__)))
