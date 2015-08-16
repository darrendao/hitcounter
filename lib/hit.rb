require 'rubygems'
require 'data_mapper'


class Hit
  include DataMapper::Resource
  property :id, Serial
  property :url, String, required: true
  property :ip_address, String, required: true
  property :created_at, DateTime
end
