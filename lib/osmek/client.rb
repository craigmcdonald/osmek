require 'faraday'
require 'yajl'
require 'hashie'

module Osmek
  class Client
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options = {})

      # Merge the option from the module with those passed to the client.
      merged_options = Osmek.options.merge(options)

      # Copy the merged option to this client and ignore the invalid ones
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end

      raise "No API key provided" if api_key.nil?
    end

    # Returns a parsed URI object
    def build_uri(path)
      URI.parse("#{Osmek.endpoint}#{Osmek.api_version}#{path}")
    end

    def api_request
      Faraday.new do |conn|
        conn.request  :url_encoded             # form-encode POST params
        conn.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    # Returns information about the account, including a list of content bins
    def account_info
      uri = build_uri('feed/account_info')
      response = api_request.post uri, { api_key: api_key }
      parsed_response = Yajl::Parser.parse(response.body)
      Hashie::Mash.new(parsed_response)
    end

    # This method validate an Osmek user's credentials.
    def check_login(options = {})
      uri = build_uri('check_login')
      response = api_request.post uri, { api_key: api_key, username: options[:username], password: options[:password] }
      parsed_response = Yajl::Parser.parse(response.body)
      Hashie::Mash.new(parsed_response)
    end
  end
end
