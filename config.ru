#\ -p 3000

# Make sure we load all the gems
require 'bundler'
Bundler.require :default

# Then connect to the database
set :database, {
  adapter: "postgresql", database: "restaurant",
  username: 'root'
}

use Rack::MethodOverride

require './app'
run Restaurant
