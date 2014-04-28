require 'bundler'
Bundler.setup

require 'scorched'

require './config/initializers/aws.rb'
require './app/controllers/collector_controller.rb'