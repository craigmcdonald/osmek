require 'faraday'

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
  end
end
