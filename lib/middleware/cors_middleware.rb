class CorsMiddleware
  
  def initialize( app )
    @app = app
  end

  def call( env )
    status  = 500
    content = []
    headers = {
      'Access-Control-Allow-Origin'      => "#{env['HTTP_ORIGIN']}",
      'Access-Control-Allow-Methods'     => 'POST, GET, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers'     => 'Content-Type, X-Requested-With, X-Prototype-Version',
      'Access-Control-Allow-Credentials' => 'true',
      'Access-Control-Max-Age'           => '1728000'
    }

    if env['REQUEST_METHOD'] == 'OPTIONS'
      status = 200
      headers.merge!( { 'Content-Type' => 'Application/json' } )
    else
      status, app_headers, content = @app.call( env )
      headers = app_headers.merge headers
    end

    [ status, headers, content ]
  end

end
