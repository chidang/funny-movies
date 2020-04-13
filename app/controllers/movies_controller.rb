class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def create
    success, messages = MovieCreator.new(movie_params, session[:user_id]).perform
    flash.merge!(messages)
    if success
      redirect_to root_path
    else
      @movie = Movie.new(movie_params)
      render :new
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:youtube_url)
  end
end
