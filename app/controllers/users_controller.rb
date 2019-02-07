class UsersController < ApplicationController

  def new
    @q = Task.ransack(params[:q])
    @user = User.new
  end

  def create
    @q = Task.ransack(params[:q])
    @user = User.create(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
