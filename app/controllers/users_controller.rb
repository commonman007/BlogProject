# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to :blogs, flash: { success: 'Successfully Logged in' }
    else
      flash[:danger] = 'User creation failed'
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
