module Osmek
  class Version
    MAJOR = 0 unless defined? Osmek::MAJOR
    MINOR = 0 unless defined? Osmek::MINOR
    PATCH = 1 unless defined? Osmek::PATCH
    PRE = nil unless defined? Osmek::PRE

    class << self

      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end

  end
end
