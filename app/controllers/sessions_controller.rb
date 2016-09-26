class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user
      log_in user
      params[:session][:remember_me] ? user.remember : user.forget
      redirect_back_or user
    else
      flash.now[:danger] = t "login.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
