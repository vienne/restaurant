require 'pg'
require 'active_record'
require 'pry'

Dir["../models/*.rb"].each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(
  adapter: "postgresql", database: "restaurant",
  host: "localhost", port: 5432
)

[
  {
    name: "Ramen",
    cuisine: "Japanese",
    price: 12,
    allergens: "Soy"
  },
   {
    name: "Udon",
    cuisine: "Japanese",
    price: 20,
    allergens: "Soy"
  },
   {
    name: "Spaghetti",
    cuisine: "American",
    price: 15,
    allergens: "None"
  },
   {
    name: "Pad Thai",
    cuisine: "Thai",
    price: 14,
    allergens: "Peanuts"
  },
  {
    name: "Tom Yum Noodle Soup",
    cuisine: "Thai",
    price: 14,
    allergens: "Shellfish"
  }
].each do |food|
  Food.create( food )
end


[
  {
    table_number: 1,
    guests: 2,
    paid: false
  },
  {
    table_number: 2,
    guests: 2,
    paid: false
  }
].each do |party|
  Party.create( party )
end

# Create some armor
[
  {
    food_id: 1,
    party_id: 1
  },
  {
    food_id:2,
    party_id:1
  },
	{
    food_id: 1,
    party_id: 2
  },
  {
    food_id: 2,
    party_id: 2
  }
].each do |order|
  Order.create( order )
end

