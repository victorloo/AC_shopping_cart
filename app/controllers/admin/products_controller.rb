class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  def index
    
  end

  private
  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not Allow!"
      redirect_to root_path
    end
  end
end