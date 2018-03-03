class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  # 幫 admin 製作一個專屬的總 controller
end