ENV['RACK_ENV'] = 'test'
gem "minitest"
require 'rack/test'
require 'minitest/autorun'
require_relative '../app.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Visit demo page 1" do
  before do
    Hit.all.destroy
  end

  it "responds with correct hit count" do
    get "/demopage1"
    last_response.status.must_equal 200
    # TODO: check last_respond.body contains count 1
  end
end
