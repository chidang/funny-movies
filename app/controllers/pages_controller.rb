class PagesController < ApplicationController
  def index
    @movies = Movie.all
  end
end
