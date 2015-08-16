require 'rubygems'
require 'data_mapper'


class Hit
  include DataMapper::Resource
  property :id, Serial
  property :url, Text, required: true
  property :ip_address, String, required: true
  property :created_at, DateTime

  # Return hit summary for a particular url
  def self.summary(url)
	  hits = Hit.all(url: url)
    results = {total_hits: hits.size}

    # Get some stats regarding visitors
    visitors = {}
    hits.each do |hit|
      visitors[hit.ip_address] ||= 0
      visitors[hit.ip_address] = visitors[hit.ip_address] + 1
    end

    results[:unique_visitors] = visitors.size
    results[:top_visitor] = visitors.max_by{|k,v| v}[0]
    return results
  end
end
