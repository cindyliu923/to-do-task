class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def change_locale
    set_locale
    redirect_to request.referer || root_url
  end
end
