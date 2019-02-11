class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :search_task
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    render_unauthorized
  end

  def change_locale
    set_locale
    redirect_to request.referer || root_url
  end

  protected

  def render_unauthorized
    render file: "#{Rails.root}/public/401", layout: false
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def search_task
    if current_user.present?
      @q = current_user.tasks.ransack(params[:q])
    else
      @q = Task.ransack(params[:q])
    end
  end

end
