# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'json'
require 'data_mapper'
require "sinatra/namespace"
require "sinatra/base"
require 'tilt/erb'
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
  erb :index
end

get '/demopage1' do
  erb :demopage1
end

get '/demopage2' do
  request.url + " " +  request.ip
  ret = Hit.create(url: request.url,
             ip_address: request.ip)
  @hits_summary = Hit.summary(request.url)
  erb :demopage2
end

get '/demopage3' do
  @hits = Hit.all
  erb :demopage3
end

# Namespacing the Hit Counter API for version 1
namespace '/api/v1' do
  get '/hits' do
    hits_summary = Hit.summary(params['url'])
    hits_summary.to_json
  end

  post '/hits' do
    a = Hit.create(url: params['url'],
               ip_address: request.ip)
    if a.id.nil?
      "error"
    else
      a.to_json
    end
  end
end
