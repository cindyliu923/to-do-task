class Admin::UsersController < ApplicationController

  def index
    @q = current_user.tasks.ransack(params[:q])
    @users = User.page(params[:page]).per(10)
  end

end
