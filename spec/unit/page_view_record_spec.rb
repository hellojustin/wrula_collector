require './spec/spec_helper.rb'
require './app/models/page_view_record.rb'

describe PageViewRecord do

  it 'can be instantiated with no arguments' do
    pvr = PageViewRecord.new
    pvr.must_be_instance_of PageViewRecord
  end

  it 'can be instantiated with an options hash' do
    pvr = PageViewRecord.new fake_request_params.merge(
      ip:         fake_ip,
      user_agent: fake_user_agent
    )
    pvr.must_be_instance_of PageViewRecord
  end

  it 'can be factoried from a request' do
    mock_request = MiniTest::Mock.new
    mock_request.expect :ip,         fake_ip
    mock_request.expect :user_agent, fake_user_agent
    mock_request.expect :params,     fake_request_params

    pvr = PageViewRecord.generate_from_request mock_request

    pvr.must_be_instance_of    PageViewRecord
    pvr.ip.must_equal          fake_ip
    pvr.user_agent.must_equal  fake_user_agent
    pvr.account_id.must_equal  fake_request_params[:account_id]
    pvr.page_domain.must_equal fake_request_params[:page_domain]
    pvr.path.must_equal        fake_request_params[:path]
    pvr.params.must_equal      fake_request_params[:params]
    pvr.visitor_id.must_equal  fake_request_params[:visitor_id]
    pvr.session_id.must_equal  fake_request_params[:session_id]
    pvr.new_visitor.must_equal fake_request_params[:new_visitor]
    pvr.new_session.must_equal fake_request_params[:new_session]
  end

  it 'will always populate its timestamp attribute' do
    pvr = PageViewRecord.new
    pvr.timestamp.must_be_instance_of Fixnum
    pvr.timestamp.to_s.must_match /\d{10}/
  end

  it 'will persist to DynamoDB' do
    pvr = PageViewRecord.new
    pvr.must_be_kind_of AWS::Record::HashModel
  end

end

def fake_ip
  '192.168.1.1'
end

def fake_user_agent
  'Mozilla/5.0 (Windows NT 5.1; rv:31.0) Firefox/31.0'
end

def fake_request_params
  {
    account_id:  '90210',
    page_domain: 'something-cool.com',
    path:        '/about_us.html',
    params:      '?utm=facebook',
    visitor_id:  '75267f0e-8032-464d-baea-3cf3249f1560',
    session_id:  '8d4acb74-cb00-4530-9e30-1957bc957fcb',
    new_visitor: true,
    new_session: true
  }
end
