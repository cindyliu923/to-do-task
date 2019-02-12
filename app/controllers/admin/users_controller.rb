class Admin::UsersController < ApplicationController
  before_action { authorize! :manage, :all }
  before_action :set_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @q = @user.tasks.ransack(params[:q])
    @tasks = @q.result.includes(:tags).order(created_at: :desc).page(params[:page]).per(8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = I18n.t("users.notice.create")
      redirect_to admin_users_path
    else
      flash.now[:alert] = I18n.t("users.alert.create")
      render :new
    end
  end

  def update
    if params[:role].present?
      update_role
    elsif @user.update_attributes(user_params)
      flash[:notice] = I18n.t("users.notice.update")
      redirect_to admin_user_path(@user)
    else
      flash.now[:alert] = I18n.t("users.alert.update")
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path
      flash[:alert] = I18n.t("users.alert.destroy")
    else
      flash[:alert] = I18n.t("common.alert.destroy")
      redirect_back(fallback_location: admin_users_path)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def update_role
    if @user.update(role: params[:role])
      flash[:notice] = I18n.t("users.notice.update")
      redirect_to admin_users_path
    else
      flash[:alert] = I18n.t("users.alert.update")
      redirect_back(fallback_location: admin_users_path)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

end
