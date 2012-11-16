require 'faraday'
require 'yajl'
require 'hashie'

module Osmek
  class Request

    attr_accessor :uri, :params

    def initialize(uri, params)
      @uri = uri
      @params = params
    end

    def perform
      response = connection.post(uri.parsed, params)
      Hashie::Mash.new(Yajl::Parser.parse(response.body))
    end

    def connection
      conn ||= Faraday.new do |conn|
        conn.request  :url_encoded
        conn.adapter  Faraday.default_adapter
        # conn.response :logger
      end
    end
  end
end
