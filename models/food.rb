class Food < ActiveRecord::Base
	has_many :orders
  has_many :parties, through: :orders

  	validates :name, uniqueness: { case_sensitive: false, 
  		message: "That item already exists!"}

end