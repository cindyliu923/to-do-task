class SessionsController < ApplicationController

  def new
    if logged_in?
      flash[:alert] = I18n.t("common.alert.login")
      redirect_to root_path
    end
  end

  def create
    user = User.find_by_email(user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = I18n.t("users.alert.login")
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end

end
