# frozen_string_literal: true
require 'bundler/setup'

require 'active_record'

include ActiveRecord::Tasks

db_dir = File.expand_path('../db', __FILE__)

DatabaseTasks.env = ENV['ENV'] || 'development'
ENV['DATABASE_URL'] = ENV['TEST_DATABASE_URL'] if DatabaseTasks.env == 'test'
DatabaseTasks.db_dir = db_dir
DatabaseTasks.migrations_paths = File.join(db_dir, 'migrate')

task :environment do
  ActiveRecord::Base.establish_connection ENV['DATABASE_URL']
end

load 'active_record/railties/databases.rake'
