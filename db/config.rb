# frozen_string_literal: true
require 'active_record'

ActiveRecord::Base.establish_connection(ENV.fetch('DATABASE_URL'))
