#\ -p 3000

# Make sure we load all the gems
require 'bundler'
Bundler.require :default

# Then connect to the database
set :database, {
  adapter: "postgresql", database: "restaurant",
  host: "localhost", port: 5432
}

use Rack::MethodOverride

require './app'
run Restaurant
