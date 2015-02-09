Dir["models/*.rb"].each do |file|
  require_relative file
end


class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :default_currency_unit, '$'
  set :default_currency_precision, 2
  set :default_currency_separator, ' '
  
  enable :sessions
  set :rest_password, "yourmom"

  before '*' do 
    unless (request.path == '/employees/login' || session[:employee_id])
      redirect to ('/employees/login')
    end
  end

  get "/console" do
    Pry.start(binding)
    ""
  end

  # homepage
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

  get '/foods/error' do
    erb :'foods/error'
  end

 	get "/foods/:id" do
 		@food = Food.find(params[:id])

 		erb :'foods/show'
 	end

 	post '/foods' do
 		food = Food.create(params[:food])
    food.name.capitalize!

    if food.valid?
      redirect to "/foods/#{food.id}"
    else
      @food = food
      @error_messages = food.errors.messages
      # redirect to "/foods/error"
      erb :'foods/new'
    end
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
  	@parties = Party.where(paid: false)

  	erb :'parties/index'
  end

  get '/parties/new' do

 		erb :'parties/new'
 	end

  get '/parties/:id' do
  	#showing all orders the party has ordered
  	@party = Party.find(params[:id])
  	@orders = @party.orders
  	#for adding new food
  	@new_food = Food.all
  	erb :'parties/show'
  end

  post '/parties' do
  	#form for adding food to the party's order
    params[:party][:employee_id] = session[:employee_id]
    party = Party.create(params[:party])
 		redirect to "parties/#{party.id}"
 	end

 	get '/parties/:id/edit' do
 		#shows the party edit form
 		@parties = Party.all
    @party = Party.find(params[:id])
    @employees = Employee.all
    erb :'parties/edit'

  end

  patch '/parties/:id' do
  	#party edit form
    @party = Party.find(params[:id])
    @party.update(params[:party])
    @foods = Food.all


    redirect to "/parties/#{@party.id}"
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

  post '/orders' do
  	order = Order.create(params[:order])
 		redirect to "parties/#{order.party_id}"
	end

  patch '/orders/:id' do
    @order = Order.find(params[:id])
    @order.update(params[:order])
    redirect to "/parties/#{@order.party_id}"
  end

  # deletes the connection between a party and a food (order is the connector)
  delete '/orders/:id' do
    @order = Order.find(params[:id])
    @order.destroy
    redirect to "/parties/#{@order.party_id}"
	end

	get '/parties/:id/receipt' do
		@party = Party.find(params[:id])
		erb :'order/receipt'
	end

	get '/parties/:id/checkout' do
		@party = Party.find(params[:id])
		erb :'parties/checkout'
	end

	patch '/parties/:id/checkout' do
		@party = Party.find(params[:id])
    @party.total= @party.foods.sum(:price)
		@party.paid = 'true'
    @party.tips = params[:party][:tips]
   
		@party.save
		
		redirect to "/parties/#{@party.id}/final"
	end

  get '/parties/:id/final' do
    @party = Party.find(params[:id])
    erb :'parties/final'
  end

  get '/employees' do
    @employee = Employee.find(session[:employee_id])

    @employees = Employee.all
    erb :'employees/index'
  end

  get '/employees/index' do
    @employees = Employee.all
    erb :'employees/index'
  end

  get '/employees/new' do
    erb :'employees/new'
  end

  post '/employees' do
    employee = Employee.create(params[:employee])
    redirect to "employees/#{employee.id}"
  end

  get '/employees/login' do
    @employees = Employee.all
    erb :'employees/login'  
  end

  post '/employees/login' do
    if params[:password] == settings.rest_password
      session[:employee_id] = params[:employee_id]
      redirect to "/parties"
    else 
      redirect to "/employees/login"
    end
  end

  get '/employees/:id' do
    @employee = Employee.find(session[:employee_id])
    # @employee = Employee.find(params[:id])
    @parties = @employee.parties
    erb :'employees/show'
  end

  get '/employees/:id/edit' do
    @employee = Employee.find(params[:id])
    erb :'employees/edit'
  end

  patch '/employees/:id' do
    employee = Employee.find(params[:id])
    employee.update(params[:employee])
    redirect to "/employees/#{employee.id}"
  end

  delete '/employees/:id' do
    employee = Employee.find(params[:id])
    employee.destroy
    redirect to "/employees"    
  end

  get '/receipts' do
    @parties = Party.all

    erb :'receipts/index'
  end

  get '/logout' do 
    session.clear
    redirect to '/employees/login'
  end

	get "/*" do
    redirect to "/employees/login"
  end

end