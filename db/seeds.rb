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

CREATE TABLE foods (
    id          SERIAL      PRIMARY KEY,
    name        TEXT        NOT NULL,
    cuisine     TEXT        NOT NULL,
    allergens   TEXT        NOT NULL,
    price       INT       NOT NULL,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP        
  );

CREATE TABLE parties (
    id              SERIAL      PRIMARY KEY,
    table_number     INT, 
    guests          INT,               
    paid           BOOLEAN       DEFAULT false,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP, 
    employee_id     INT         NOT NULL,
    tips            INT         DEFAULT 0,
    total           INT         DEFAULT 0
            
  );

CREATE TABLE orders (
    id            SERIAL      PRIMARY KEY,
    food_id       INT,
    party_id      INT,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP,
    free          BOOLEAN     DEFAULT false
    );


CREATE TABLE employees (
    id            SERIAL      PRIMARY KEY,
    name          TEXT        NOT NULL
  );



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
  },
  {
    name: "Taiwanese Beef Noodle Soup",
    cuisine: "Taiwanese",
    price: 14,
    allergens: "Soy"
  },
  {
    name: "Yakisoba",
    cuisine: "Japanese",
    price: 14,
    allergens: "Soy"
  },
  
  {
    name: "Laksa",
    cuisine: "Malaysian",
    price: 14,
    allergens: "Shellfish"
  },


].each do |food|
  Food.create( food )
end


[
  {
    table_number: 1,
    guests: 2,
    paid: false,
    employee_id: 3,
    tips: 3,
    total: 20
  },
  {
    table_number: 2,
    guests: 2,
    paid: false,
    employee_id: 3,
    tips: 4,
    total: 18
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


[
  {
    name: Yaniv
    
  },
  {
    
    name: Jessie
  },
  {
    
    name: Robin
  },
  {
    name: Matt
  }
].each do |employee|
  Employee.create( employee )
end


