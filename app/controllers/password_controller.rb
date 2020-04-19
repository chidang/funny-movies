class PasswordController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_index_path(@user), notice: "Your password has been updated."
    else
      render :edit
    end
  end

  private

  def set_user
    @user ||= User.find(session[:user_id])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end