module Osmek
  module Configuration
    VALID_CONNECTION_KEYS  = [:endpoint, :api_version, :user_agent, :method].freeze
    VALID_OPTIONS_KEYS     = [:api_key, :format].freeze
    VALID_CONFIG_KEYS      = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    # TODO Split endpoint into protocol and hostname
    DEFAULT_ENDPOINT       = 'http://api.osmek.com/'
    DEFAULT_API_VERSION    = nil
    DEFAULT_USER_AGENT     = "Osmek API Ruby Gem #{Osmek::VERSION}".freeze
    DEFAULT_METHOD         = :post
    DEFAULT_API_KEY        = nil
    DEFAULT_FORMAT         = :json

    # Build accessor methods for every config key so we can do this:
    #   Osmek.format = :xml
    attr_accessor *VALID_CONFIG_KEYS

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end

    def reset
      self.endpoint       = DEFAULT_ENDPOINT
      self.api_version    = DEFAULT_API_VERSION
      self.user_agent     = DEFAULT_USER_AGENT
      self.method         = DEFAULT_METHOD
      self.api_key        = DEFAULT_API_KEY
      self.format         = DEFAULT_FORMAT
    end

    # Allow configuration via a block
    def configure
      yield self
    end

    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
  end
end
