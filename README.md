# hitcounter
[![Build Status](https://travis-ci.org/darrendao/hitcounter.svg?branch=master)](https://travis-ci.org/darrendao/hitcounter)

This repo is a coding exercise for implementing a hit counter.

Demo: http://hitcounter-env.elasticbeanstalk.com/

## Requirements
* Ruby 1.9.x or greater (tested with 1.9.3-p429 and 2.0.0-p353). Refer to rbenv or RVM for managing your Ruby installations.
* bundler gem installed (needed for dependency management)
```
sudo gem install bundler
```
* Install native dev packages for ruby, sqlite, libxslt and libxml2. For example, on Centos, you can run
```
sudo yum install ruby-devel
sudo yum groupinstall 'Development Tools'
sudo yum install sqlite-devel
sudo yum install libxml2-devel libxslt-devel
```
* On Ubuntu, you can run
```
sudo apt-get install build-essential
sudo apt-get install ruby-dev
sudo apt-get install libsqlite3-dev
sudo apt-get install libxslt-dev libxml2-dev
```
* Install all Ruby gems dependency
```
bundle install
```
## Development
* To start the app in development mode
```
ruby app.rb
```
To populate the database with test data
```
rake db:seed
```

## Running tests
* Tests are written as specs and stored under the spec directory.
* Tests can be run as followed
```
RACK_ENV=test rake test
```
* This repo has been integrated with Travis CI. When changes are made to the repo, Travis CI will automatically run the tests.


## Production Deployment
* I would recommend running the Sinatra web app using Puma or Passenger and nginx.
* Use RDS for database backend
* Or better use, deploy the app using Amazon Elastic Beanstalk. Don't forget to update the DATABASE_URL environment variable so the app knows how to connect to the database.

## TODO
There are many features/improvements I would like to add. Here are some of them (not in any particular order)
* Aggregate/cache hits count in order to improve performance
* Provide more interesting trending stats
* Use ElasticSearch to provide users better way to analyze their stats

