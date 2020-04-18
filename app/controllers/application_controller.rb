class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :authorize
  skip_before_filter :verify_authenticity_token

  private

  def authorize
    redirect_to root_path, notice: "Please Login or Register" unless User.find_by(id: session[:user_id])
  end
end
