require './config/environment.rb'
require './app/models/page_view_record.rb'

desc "Generates fake PageViewRecords and saves them to DynamoDB"
task :seed_data do
  
  records_created   = 0
  records_to_create = 1000000

  accounts = [ {
    account_id: 90210,
    pages:      [ {
      page_domain:     'www.element84.com',
      path:       '/',
      params:     ''
    }, {
      page_domain:     'www.element84.com',
      path:       'how-we-work',
      params:     ''
    } ]
  }, { 
    account_id: 90210, 
    pages:      [ {
      page_domain:     'reverb.echo.nasa.gov',
      path:       'reverb/',
      params:     'utf8=%E2%9C%93&spatial_map=satellite&spatial_type=rectangle'
    }, {
      page_domain:     'www.echo.nasa.gov',
      path:       'about_reverb.htm',
      params:     ''
    }, {
      page_domain:     'www.echo.nasa.gov',
      path:       '/reverb/tutorial/Tutorial.html',
      params:     ''
    } ]
  }, { 
    account_id: 75309, 
    pages:      [ {
      page_domain:     'www.cloqworq.com',
      path:       '/',
      params:     ''
    }, {
      page_domain:     'www.cloqworq.com',
      path:       'plan',
      params:     ''
    } ]
  } ]

  visitors = [ {
    visitor_id:   SecureRandom.uuid,
    session_id:   SecureRandom.uuid,
    new_visitor:  false,
    new_session:  false,
    user_agent:   'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1944.0 Safari/537.36',
    ip:           '192.168.1.1'
  }, {
    visitor_id:   SecureRandom.uuid,
    session_id:   SecureRandom.uuid,
    new_visitor:  false,
    new_session:  true,
    user_agent:   'Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0',
    ip:           '173.79.179.63'
  }, {
    visitor_id:   SecureRandom.uuid,
    session_id:   SecureRandom.uuid,
    new_visitor:  false,
    new_session:  false,
    user_agent:   'Mozilla/5.0 (compatible; MSIE 10.6; Windows NT 6.1; Trident/5.0; InfoPath.2; SLCC1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 2.0.50727) 3gpp-gba UNTRUSTED/1.0',
    ip:           '10.54.88.163'
  }, {
    visitor_id:   SecureRandom.uuid,
    session_id:   SecureRandom.uuid,
    new_visitor:  true,
    new_session:  true,
    user_agent:   'Googlebot/2.1 (+http://www.googlebot.com/bot.html)',
    ip:           '240.61.204.17'
  } ]

  while records_created < records_to_create do
    account = accounts.sample
    page    = account[:pages].sample
    visitor = visitors.sample

    pvr = PageViewRecord.new( {
      account_id:  account[:account_id],

      page_domain:      page[:page_domain],
      path:        page[:path],
      params:      page[:params],

      ip:          visitor[:ip],
      user_agent:  visitor[:user_agent],
      visitor_id:  visitor[:visitor_id],
      session_id:  visitor[:session_id],
      new_visitor: visitor[:new_visitor],
      new_session: visitor[:new_session]
    } )

    pvr.save

    if records_created % 100 == 0
      puts "PVR #{records_created} created, #{records_to_create - records_created} to go."
    end

    records_created += 1
  end

end
