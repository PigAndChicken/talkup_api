ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'rake'

load 'Rakefile'

Rake::Task['db:reset'].invoke


require_relative './test_load_all.rb'

