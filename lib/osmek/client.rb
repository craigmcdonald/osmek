require 'osmek/uri'
require 'osmek/request'

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

    def default_params
      { api_key: api_key }
    end

    # API calls

    # Returns information about the account, including a list of content bins
    def account_info
      uri = Osmek::Uri.new('feed/account_info')
      request = Osmek::Request.new(uri, default_params)
      request.perform
    end

    # Validates an Osmek user's credentials.
    def check_login(params = {})
      merged_params = default_params.merge(params)
      uri = Osmek::Uri.new('check_login')
      request = Osmek::Request.new(uri, merged_params)
      request.perform
    end

    # Returns information about a content bin
    def section_info(params = {})
      merged_params = default_params.merge(params)
      uri = Osmek::Uri.new('feed/section_info')
      request = Osmek::Request.new(uri, merged_params)
      request.perform
    end

    # Works just like the feed method, but returns comments for an item
    def comments(params = {})
      merged_params = default_params.merge(params)
      uri = Osmek::Uri.new('feed/comments')
      request = Osmek::Request.new(uri, merged_params)
      request.perform
    end

    # Allows you to add a comment to an item
    def make_comment(params = {})
      merged_params = default_params.merge(params)
      uri = Osmek::Uri.new('make_comment')
      request = Osmek::Request.new(uri, merged_params)
      request.perform
    end

    # Allows you to add a comment to an item
    def log(params = {})
      merged_params = default_params.merge(params)
      uri = Osmek::Uri.new('log')
      request = Osmek::Request.new(uri, merged_params)
      request.perform
    end
  end
end
