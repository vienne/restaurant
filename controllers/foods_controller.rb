class FoodsController < ApplicationController

	get "/" do
  	@foods = Food.all

  	erb :'foods/index'
 	end

 	get '/new' do
    
 		erb :'foods/new'
 	end

  get '/error' do
    erb :'foods/error'
  end

 	get "/:id" do
 		@food = Food.find(params[:id])

 		erb :'foods/show'
 	end

 	post '/' do
 		food = Food.create(params[:food])
    food.name.capitalize!

    if food.valid?
      redirect to "/#{food.id}"
    else
      @food = food
      @error_messages = food.errors.messages
      # redirect to "/foods/error"
      erb :'foods/new'
    end
  end
  
 	get '/:id/edit' do
    @food = Food.find(params[:id])
    erb :'foods/edit'
  end

  patch '/:id' do
    food = Food.find(params[:id])
    food.update(params[:food])

    redirect to "/#{food.id}"
  end

  delete '/:id' do
    food = Food.find(params[:id])
    food.destroy
    redirect to "/"    
  end


end