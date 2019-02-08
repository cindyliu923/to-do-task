class Admin::UsersController < ApplicationController
  before_action :authorize
  before_action :set_user, :only => [:show, :edit, :update, :destroy]
  before_action :search_task

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @q = @user.tasks.ransack(params[:q])
    @tasks = @q.result.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = I18n.t("users.notice.create")
      redirect_to admin_users_url
    else
      flash.now[:alert] = I18n.t("users.alert.create")
      render :action => :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = I18n.t("users.notice.update")
      redirect_to admin_user_path(@user)
    else
      flash.now[:alert] = I18n.t("users.alert.update")
      render :action => :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url
    flash[:alert] = I18n.t("users.alert.destroy")
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def search_task
    @q = Task.ransack(params[:q])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
