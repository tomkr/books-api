require 'database_cleaner'
require 'database_cleaner/cucumber'

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :truncation

Around do |_scenario, block|
  DatabaseCleaner.cleaning(&block)
end
