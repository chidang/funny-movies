class PagesController < ApplicationController
  skip_before_action :authorize

  def index
    @movies = Movie.order('created_at desc').page(params[:page])
  end
end
