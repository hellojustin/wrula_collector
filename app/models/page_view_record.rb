class PageViewRecord < AWS::Record::HashModel

  # about the record itself
  string_attr  :id
  integer_attr :timestamp

  # about the account
  string_attr  :account_id
  
  # about the page
  string_attr  :page_domain
  string_attr  :path
  string_attr  :params

  # about the visitor
  string_attr  :ip
  string_attr  :user_agent
  string_attr  :visitor_id
  string_attr  :session_id
  boolean_attr :new_visitor
  boolean_attr :new_session

  # class methods
  class << self
    def generate_from_request request
      params = request.params.merge(
        ip:         request.ip,
        user_agent: request.user_agent
      )
      PageViewRecord.new params
    end
  end

  def initialize attrs = {}
    attrs.merge! timestamp: Time.now.to_i 
    super attrs
  end

end