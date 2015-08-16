ENV['RACK_ENV'] = 'test'
gem "minitest"
require 'rack/test'
require 'minitest/autorun'
require_relative '../app.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Visit demo page 2" do
  before do
    Hit.all.destroy
  end

  it "responds with correct summary" do
    get "/demopage2"
    last_response.status.must_equal 200
    # TODO: check last_respond.body contains count 1
		last_response.body.must_include "<div class=\"huge\" id=\"total_hits\">1</div>"
		last_response.body.must_include "<div class=\"huge\" id=\"unique_visitors\">1</div>"

    get "/demopage2"
    last_response.status.must_equal 200
		last_response.body.must_include "<div class=\"huge\" id=\"total_hits\">2</div>"
		last_response.body.must_include "<div class=\"huge\" id=\"unique_visitors\">1</div>"
  end
end

describe "POST and GET API endpoint" do
  before do
    Hit.all.destroy
  end

  it "update hit count correctly" do
  	post "/api/v1/hits", params = {url: 'url1', ip_address: '1.2.3.4'}
  	last_response.status.must_equal 200
    get "/api/v1/hits?url=url1"
    last_response.status.must_equal 200
    
		post "/api/v1/hits", params = {url: 'url1', ip_address: '1.2.3.5'}
    last_response.status.must_equal 200
    
  	get "/api/v1/hits?url=url1"
  	last_response.status.must_equal 200
    
  	hits = JSON.parse(last_response.body)
  	assert_equal(2, hits["total_hits"])
  	assert_equal(1, hits["unique_visitors"])
  	assert_equal("127.0.0.1", hits["top_visitor"])
  end

  it "doesn't crash when querying hit count for non-existing url" do
    post "/api/v1/hits", params = {url: 'url1', ip_address: '1.2.3.4'}
    last_response.status.must_equal 200

    get "/api/v1/hits?url=nonexistingurl"
    last_response.status.must_equal 200    
  end

  it "returns correct hits count depending on param query string" do
    post "/api/v1/hits", params = {url: 'url1', ip_address: '1.2.3.4'}
    last_response.status.must_equal 200

    post "/api/v1/hits", params = {url: 'url2', ip_address: '1.2.3.5'}
    last_response.status.must_equal 200

    get "/api/v1/hits"
    hits = JSON.parse(last_response.body)
    assert_equal(2, hits["total_hits"])

    get "/api/v1/hits?url=url1"
    hits = JSON.parse(last_response.body)
    assert_equal(1, hits["total_hits"])

    get "/api/v1/hits?url=url2"
    hits = JSON.parse(last_response.body)
    assert_equal(1, hits["total_hits"])

  end
end