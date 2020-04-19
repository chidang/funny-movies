class MoviesController < ApplicationController
  before_action :set_movie, only: [:edit, :update]

  def new
    @movie = Movie.new
  end

  def create
    success, messages = MovieCreator.new(params: movie_params, user_id: session[:user_id]).perform
    flash.merge!(messages)
    if success
      redirect_to root_path
    else
      @movie = Movie.new(movie_params)
      render :new
    end
  end

  def edit
    redirect_to root_path if @movie.user_id != session[:user_id]
  end

  def update
    success, messages = MovieCreator.new(params: movie_params, user_id: session[:user_id], movie: @movie).perform
    flash.merge!(messages)
    if success
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_movie
    @movie ||= Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:youtube_url)
  end
end
