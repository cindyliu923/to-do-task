class UsersController < ApplicationController

  def new
    if logged_in?
      flash[:alert] = I18n.t("common.alert.login")
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to '/login'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
