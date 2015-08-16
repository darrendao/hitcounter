# Rakefile
require 'json'
require 'rake/testtask'
require './lib/hit.rb'

task :default => :test

desc "Run all tests"
task :test do
  Rake::TestTask.new do |t|
    t.pattern = "spec/*_spec.rb"
  end
end

namespace :db do
  task :seed do
		env = ENV['RACK_ENV'] || "development"
    DataMapper::Model.raise_on_save_failure

    DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/#{env}.db")
    DataMapper.finalize
    DataMapper.auto_upgrade!

    100.times.each do 
	    random_ip = Array.new(4){rand(256)}.join('.')
	    url = "http://hitcounter-env.elasticbeanstalk.com/demopage#{rand(10)}"
  	  Hit.create(url: url,
	               ip_address: random_ip)

    end
  end
end