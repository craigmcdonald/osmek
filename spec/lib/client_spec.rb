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
    params = {api_key: nil}
    expect { Osmek::Client.new(params) }.to raise_exception "No API key provided"
  end

  # TODO Use https://github.com/myronmarston/vcr instead

  describe 'API calls' do
    before do
      @params = {
        username: ENV['USERNAME'],
        password: ENV['PASSWORD']
      }
      @client = Osmek::Client.new(api_key: ENV['API_KEY'])
    end

    after do
      Osmek.reset
    end

    describe '.account_info' do
      before { @response = @client.account_info }
      subject { @response }

      it { should respond_to(:id) }
    end

    describe '.check_login' do
      context 'with valid user' do
        before { @response = @client.check_login(@params) }
        subject { @response }

        its(:status) { should eq 'ok' }
        its(:token) { should be_nil }
      end

      context 'with invalid user' do
        before { @response = @client.check_login(@params.merge(password: 'invalid')) }
        subject { @response }

        its(:status) { should eq 'fail' }
      end

      context 'with return_token' do
        before { @response = @client.check_login(@params.merge(return_token: true)) }
        subject { @response }

        its(:status) { should eq 'ok' }
        it { should respond_to(:token) }
      end
    end

    describe '.section_info' do
      context 'with empty params' do
        before { @response = @client.section_info }
        subject { @response }

        its(:status) { should eq 'fail' }
      end

      context 'with wrong section_id' do
        before { @response = @client.section_info(section_id: 0000) }
        subject { @response }

        its(:status) { should eq 'fail' }
      end

      context 'with correct section_id' do
        before { @response = @client.section_info(section_id: ENV['SECTION_ID']) }
        subject { @response }

        it { should respond_to(:id) }
      end
    end

    describe '.comments' do
      context 'with empty params' do
        before { @response = @client.comments }
        subject { @response }

        its(:status) { should eq 'fail' }
      end

      context 'with wrong section_id' do
        before { @response = @client.comments(section_id: 0000) }
        subject { @response }

        its(:status) { should eq 'fail' }
      end

      context 'with just section_id' do
        before { @response = @client.comments(section_id: ENV['SECTION_ID']) }
        subject { @response }

        its(:status) { should eq 'fail' }
      end

      context 'with section_id and wrong item_id' do
        before { @response = @client.comments(
          section_id: ENV['SECTION_ID'],
          item_id: 0000
        ) }
        subject { @response }

        it { should respond_to(:items) }
        its(:items) { should be_empty }
      end

      context 'with section_id and item_id' do
        before { @response = @client.comments(
          section_id: ENV['SECTION_ID'],
          item_id: ENV['ITEM_ID']
        ) }
        subject { @response }

        it { should respond_to(:items) }
      end
    end

  end
end
