class Admin::StaticPagesController < ApplicationController
  before_action :logged_in_user, :verify_admin

  def home
  end
end
