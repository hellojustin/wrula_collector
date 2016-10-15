require 'rake'
require './config/environment.rb'

Dir["lib/tasks/**/*.rake"].each do |rake_file|
  load rake_file
end

task default: 'test'
