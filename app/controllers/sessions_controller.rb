class SessionsController < ApplicationController
  skip_before_action :authorize

  def create
    logged_in_data, messages = UserPerformer.new(user_params).perform
    session.merge!(logged_in_data)
    flash.merge!(messages)
    redirect_to root_path
  end

  def destroy
    session[:user_email] = nil
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
