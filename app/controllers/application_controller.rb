class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "flash.not_logged_in"
      redirect_to login_url
    end
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "flash.not_admin"
      redirect_to root_url
    end
  end

  def load_subjects
    @subjects = Subject.all
    @subjects_select = @subjects.collect{|subject| [subject.name, subject.id]}
  end
end
