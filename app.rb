Dir["models/*.rb"].each do |file|
  require_relative file
end

class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  
  # Console
  get "/console" do
    Pry.start(binding)
    ""
  end

  get "/" do

  	erb :index
  end

  get "/foods" do
  	@foods = Food.all

  	erb :'foods/index'
 	end

 	get '/foods/new' do
 		erb :'foods/new'
 	end

 	get "/foods/:id" do
 		@food = Food.find(params[:id])

 		erb :'foods/show'
 	end

 	post '/foods' do
 		food = Food.create(params[:food])
 		redirect to "foods/#{food.id}"
 	end

 	get '/foods/:id/edit' do
    @food = Food.find(params[:id])
    erb :'foods/edit'
  end

  patch '/foods/:id' do
    food = Food.find(params[:id])
    food.update(params[:food])

    redirect to "/foods/#{food.id}"
  end

  delete '/foods/:id' do
    food = Food.find(params[:id])
    food.destroy
    redirect to "/foods"    
  end

  get '/parties' do
  	@parties = Party.all
  	erb :'parties/index'
  end

  get '/parties/new' do
 		erb :'parties/new'
 	end

  get '/parties/:id' do
  	#showing all orders the party has ordered
  	@party = Party.find(params[:id])
  	@food = @party.foods
  	#for adding new food
  	@new_food = Food.all
  	erb :'parties/show'
  end

  post '/parties' do
  	#form for adding food to the party's order
 		party = Party.create(params[:party])
 		redirect to "parties/#{party.id}"
 	end

 	get '/parties/:id/edit' do
 		#shows the party edit form
 		@parties = Party.all
    @party = Party.find(params[:id])
    erb :'parties/edit'
  end

  patch '/parties/:id' do
  	#party edit form
    @party = Party.find(params[:id])
    @party.update(params[:party])
    @foods = Food.all


    redirect to "/parties/#{party.id}"
  end

  delete '/parties/:id' do
  	#deleting party 
    party = Party.find(params[:id])
    party.destroy
    redirect to "/parties"    
  end

  

  delete '/parties/:id' do
  	#deleting party 
    party = Party.find(params[:id])
    party.foods.destroy(params[:food])
    redirect to "/parties"    
  end

  # get '/parties/:id/foods/edit' do
  # 	@party = Party.find(params[:id])
  # 	@food = @party.foods

  # 	erb :'parties/food_edit'
  # end

  # delete '/parties/:id/foods' do
  # 	party = Party.find(params[:id])
  # 	foods = party.orders.find(params[:id])
  # end
 



  post '/orders' do
  	order = Order.create(params[:order])
 		redirect to "parties/#{order.party_id}"
	end

  patch '/orders/:id' do

  end

  delete '/orders' do

	end

	get '/parties/:id/receipt' do
		@party = Party.find(params[:id])
		erb :'order/receipt'
	end

	get '/parties/:id/checkout' do
		@party = Party.find(params[:id])
		erb :'parties/checkout'
	end

	patch '/parties/:id' do
		@party = Party.find(params[:id])
		@party.paid = 'true'
		@party.save
		
		redirect to "parties/#{party.id}"
	end


	get "/*" do
    redirect to "/parties"
  end

end