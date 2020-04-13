class PagesController < ApplicationController
  skip_before_action :authorize

  def index
    @movies = Movie.all
  end
end
