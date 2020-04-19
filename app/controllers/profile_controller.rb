class ProfileController < ApplicationController

  def index
    @user = User.find(session[:user_id])
    @movies = @user.movies
  end
end