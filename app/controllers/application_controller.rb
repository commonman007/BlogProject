# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorize

  private

  # identifying the current logged in user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  # redirecting to signup or saving user_id into cookies
  def authorize
    current_user
    if current_user.nil?
      redirect_to signup_url, alert: 'Not authorized'
    else
      cookies[:user_id] = current_user.id
    end
  end
end
