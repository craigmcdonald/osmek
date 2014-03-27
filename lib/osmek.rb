require 'osmek/version'
require 'osmek/configuration'
require 'osmek/client'

if Rails.env.development?
  require 'dotenv'
  Dotenv.load
end

module Osmek

  extend Configuration

end
