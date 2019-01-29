class TweetsController < ApplicationController

  get "/tweets" do
    @session = session
    @tweets = Tweet.all
    if session["user_id"]
      erb :"/tweets/index"
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if Helper.logged_in(session)
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end


  post "/tweets" do
    tweet = Helper.current_user(session).tweets.build(params)
    if tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get "/tweets/:id" do
    if Helper.logged_in(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if Helper.logged_in(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/edit"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    tweet = Tweet.find_by_id(params[:id])
    if tweet
      tweet.update(params[:tweet]) if tweet.user = Helper.current_user(session)
    end
    if tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete "/tweets/:id/delete" do
    tweet = Tweet.find_by_id(params[:id])
    if tweet.user == User.find_by_id(session["user_id"])
      tweet.destroy
    end
    redirect "/tweets"
  end


end