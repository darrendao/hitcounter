# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'json'
require 'data_mapper'
require "sinatra/namespace"
require "sinatra/base"
require './lib/hit.rb'

configure :development, :test, :production do
  register ::Sinatra::Namespace
  set :protection, true
  set :protect_from_csrf, true
  set :bind, '0.0.0.0'
end

env = ENV['RACK_ENV'] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/#{env}.db")
DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  hits = Hit.all
  hits.to_json
end

get '/demopage1' do
  request.url + " " +  request.ip
  Hit.create(url: request.url,
             ip_address: request.ip)
  puts "HIT COUNT ADDD"
  @hit_count = Hit.count(url: request.url)
  erb :demopage1
end

get '/demopage2' do
  erb :demopage2
end

# Namespacing the Hit Counter API for version 1
namespace '/api/v1' do
  get '/hits' do
    hit_count = Hit.count(url: params['url'])
    {hit_count: hit_count}.to_json
  end

  post '/hits' do
    Hit.create(url: params['url'],
               ip_address: request.ip)
  end
end
