class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_user, except: :index

  def show
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def destroy
    if @user.destroy
      flash[:success] = t "destroy.success"
      redirect_to admin_users_url
    else
      flash[:danger] = t "destroy.danger"
      redirect_to root_url
    end
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "find_user.danger"
      redirect_to root_url
    end
  end
end
