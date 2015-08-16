# hitcounter
[![Build Status](https://travis-ci.org/darrendao/hitcounter.svg?branch=master)](https://travis-ci.org/darrendao/hitcounter)
This repo is a coding exercise for implementing a hit counter.

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
## Production Deployment

## Development

## Running tests
* Tests are written as specs and stored under the spec directory.
* Tests can be run as followed
```
RACK_ENV=test rake test
```
* This repo has been integrated with Travis CI. When changes are made to the repo, Travis CI will automatically run the tests.
