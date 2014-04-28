require './lib/middleware/cors.rb'
require './app/models/page_view_record.rb'

class CollectorController < Scorched::Controller

  include Cors

  post '/' do
    PageViewRecord.generate_from_request( request ).save
  end

  get '/' do
    'It Runs!'
  end

end