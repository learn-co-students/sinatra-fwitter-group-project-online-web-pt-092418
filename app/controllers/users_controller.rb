class UsersController < ApplicationController

  get "/signup" do
    @session = session
    unless @session["user_id"]
      erb :"/users/signup"
    else
      redirect "/tweets"
    end
  end

  get "/users/:slug" do
    user = User.deslug(params[:slug])
    @tweets = user.tweets
    erb :"/tweets/show"
  end

  post "/signup" do
    user = User.new(params)
    if user.save
      session["user_id"] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end

  end

  get "/login" do
    unless session["user_id"]
      erb :"/users/login"
    else
      redirect "/tweets"
    end
  end

  post "/login" do
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session["user_id"] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end


  get "/logout" do
    if session["user_id"]
      session.clear
      redirect "/login"
    else
      redirect "/login"
    end

  end

end