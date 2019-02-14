class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :search_task
  helper_method [:current_user, :logged_in?]

  rescue_from CanCan::AccessDenied do |exception|
    if logged_in?
      render_unauthorized
    else
      redirect_to '/login'
    end
  end

  def change_locale
    set_locale
    redirect_to request.referer || root_url
  end

  protected

  def render_unauthorized
    render file: "#{Rails.root}/public/401", layout: false, status: 401
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def search_task
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @q = @user.tasks.ransack(params[:q])
    elsif current_user.present?
      @q = current_user.tasks.ransack(params[:q])
    else
      @q = nil
    end
  end

end
