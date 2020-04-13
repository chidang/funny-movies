class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize

  private

  def authorize
    redirect_to root_path, notice: "Please Login or Register" unless User.find_by(id: session[:user_id])
  end
end
