class Admin::UsersController < ApplicationController

  def index
    @q = current_user.tasks.ransack(params[:q])
  end

end
