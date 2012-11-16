module Osmek
  class Uri

    attr_accessor :parsed

    def initialize(path)
      @parsed = URI.parse("#{Osmek.endpoint}#{Osmek.api_version}#{path}")
    end
  end
end
