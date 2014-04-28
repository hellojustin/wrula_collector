require './lib/middleware/cors_middleware.rb'

module Cors

  def included context
    context.middleware << proc do 
      use CorsMiddleware
    end
  end

end