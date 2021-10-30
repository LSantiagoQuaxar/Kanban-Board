require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions

   
    set :session_secret, 'Development'
    
  end

  get "/" do
    unauthorized_redirect
    redirect "/projects"
  end

  get "/login" do
    erb :login
  end
  
  post "/login" do
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/"
    else
      session[:errors] = Array.new()
      if !@user
        session[:errors] << "Ningún usuario con ese nombre"
      elsif !@user.authenticate(params[:password])
        session[:errors] << "Contraseña incorrecta"
      end
      redirect back
    end
  end

  get "/logout" do
    unauthorized_redirect
    session.clear
    redirect "/login"
  end
  
  get "/signup" do
    erb :signup
  end

  post "/signup" do
    @user = User.new(params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect "/"
    else
      session[:errors] = Hash(@user.errors)
      redirect back
    end
  end

  def unauthorized_redirect
    3.times {puts ""}
    puts "session|#{session[:user_id]}|"
    3.times {puts ""}
    if !logged_in?
      redirect "/login"
    end
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def current_user
    if logged_in?
      User.find_by_id(session[:user_id])
    end
  end
end

