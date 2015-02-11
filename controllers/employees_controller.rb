class EmployeesController < ApplicationController



  get '/' do
    @employee = Employee.find(session[:employee_id])

    @employees = Employee.all
    erb :'employees/index'
  end

  get '/index' do
    @employees = Employee.all
    erb :'employees/index'
  end

  get '/new' do
    erb :'employees/new'
  end

  post '/' do
    employee = Employee.create(params[:employee])
    redirect to "#{employee.id}"
  end

  get '/login' do
    @employees = Employee.all
    erb :'employees/login'  
  end

  post '/login' do
    if params[:password] == settings.rest_password
      session[:employee_id] = params[:employee_id]
      redirect to "/parties"
    else 
      redirect to "/login"
    end
  end

  get '/:id' do
    @employee = Employee.find(session[:employee_id])
    # @employee = Employee.find(params[:id])
    @parties = @employee.parties
    erb :'employees/show'
  end

  get '/:id/edit' do
    @employee = Employee.find(params[:id])
    erb :'employees/edit'
  end

  patch '/:id' do
    employee = Employee.find(params[:id])
    employee.update(params[:employee])
    redirect to "/#{employee.id}"
  end

  delete '/:id' do
    employee = Employee.find(params[:id])
    employee.destroy
    redirect to "/"    
  end

  get '/logout' do 
    session.clear
    redirect to '/login'
  end
end