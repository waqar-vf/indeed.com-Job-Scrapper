module Snovio
  include HTTParty
  default_timeout 10000
  @access_token_uri = "https://app.snov.io/oauth/access_token"
  @get_emails_uri = "https://app.snov.io/restapi/get-domain-emails-with-info"
  def self.get_access_token
    @result = HTTParty.post(@access_token_uri,
                            :body => {:client_id => 'b3b88e7d22801716f9dde2cffde66526',
                                      :client_secret => '851fe5ec5e7922ea8ddcc7d568f0e4b1',
                                      :grant_type => 'client_credentials'}.to_json ,
                            :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
    @result['access_token']
  end
  def self.get_emails web_address , access_token
    web_address.slice! "www."
    # begin
    #   puts "----first begin-------------"
      @result = HTTParty.post(@get_emails_uri,
                              :body => {:domain => web_address,
                                        :type => 'all',
                                        :limit => '100'}.to_json ,
                              :headers => {'Content-Type' => 'application/json',
                                           'Accept' => 'application/json',
                                           'Authorization' => "Bearer #{access_token}"})
    # rescue error

        # raise "Something went wrong! /lib/snovio/* "
      # puts "----------------#{error.inspect}=================="
    # end

  end
end