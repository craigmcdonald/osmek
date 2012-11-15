require 'spec_helper'
require 'yajl'

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

  it "should raise an exception if no API key is set" do
    config = {api_key: nil}
    expect { Osmek::Client.new(config) }.to raise_exception "No API key provided"
  end

  # TODO Use https://github.com/myronmarston/vcr instead

  describe 'API calls' do
    before do
      config = {api_key: ENV['API_KEY']}
      @client = Osmek::Client.new(config)
    end

    after do
      Osmek.reset
    end

    describe '.account_info' do
      before { @response = @client.account_info }
      subject { @response }
      it { should respond_to(:id) }
      it { should respond_to(:email) }
    end

    describe '.check_login' do
      context 'with valid user' do
        before do
          @response = @client.check_login(
            username: ENV['USERNAME'],
            password: ENV['PASSWORD']
          )
        end
        subject { @response }
        its(:status) { should eq 'ok' }
        its(:msg) { should eq 'User validated' }
        its(:token) { should be_nil }
      end

      context 'with invalid user' do
        before do
          @response = @client.check_login(
            username: ENV['USERNAME'],
            password: 'invalid'
          )
        end
        subject { @response }
        its(:status) { should eq 'fail' }
        its(:msg) { should eq 'Invalid username or password' }
      end

      context 'with return_token' do
        before do
          @response = @client.check_login(
            username: ENV['USERNAME'],
            password: ENV['PASSWORD'],
            return_token: true
          )
        end
        subject { @response }
        its(:status) { should eq 'ok' }
        its(:msg) { should eq 'User validated' }
        it { should respond_to(:token) }
      end
    end

  end
end
