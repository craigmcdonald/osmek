require 'spec_helper'

describe Osmek::Client do

  before do
    @keys = Osmek::Configuration::VALID_CONFIG_KEYS
  end

  describe "with default configuration" do
    before do
      Osmek.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Osmek.reset
    end

    it "should inherit default configuration" do
      client = Osmek::Client.new
      @keys.each do |key|
        client.send(key).should eq key
      end
    end
  end
end
