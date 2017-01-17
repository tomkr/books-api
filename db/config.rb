# frozen_string_literal: true
require 'active_record'

config_dir = File.expand_path('../../config', __FILE__)
ActiveRecord::Base.configurations =
  YAML.load(File.read(File.join(config_dir, 'database.yml')))
ActiveRecord::Base.establish_connection(
  ENV.fetch('ENV', 'development').to_sym
)
