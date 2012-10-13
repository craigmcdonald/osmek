require 'faraday'
require 'oj'

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
    end

    # Returns a parsed URI object
    def build_uri(path)
      URI.parse("#{Osmek.endpoint}#{Osmek.api_version}#{path}")
    end

    def prepare_request(uri)
      Faraday.new(:url => uri) do |conn|
        conn.request  :url_encoded             # form-encode POST params
        conn.response :logger                  # log requests to STDOUT
        conn.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    # Returns information about the account, including a list of content bins
    def account_info
      uri = build_uri('/feed/account_info')
      request = prepare_request(uri)
      response = request.post
      parsed_response = Oj.dump(response.body)
    end
  end
end
