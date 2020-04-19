class SessionsController < ApplicationController
  skip_before_action :authorize

  def create
    status, logged_in_data, messages = UserPerformer.new(user_params).perform
    if status
      create_success(logged_in_data)
    else
      create_failure(messages)
    end
  end

  def destroy
    session[:user_email] = session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def create_success(logged_in_data)
    session.merge!(logged_in_data)
    redirect_to root_path
  end

  def create_failure(messages)
    flash.now[:danger] = messages[:danger]
    @user = User.new(user_params)
    @movies = Movie.page(params[:page])
    render "pages/index"
  end
end
