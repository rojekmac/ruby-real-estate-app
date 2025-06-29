class LanguageController < ApplicationController
  def switch
    locale = params[:locale]

    if I18n.available_locales.map(&:to_s).include?(locale)
      session[:locale] = locale
      I18n.locale = locale
    end

    redirect_back(fallback_location: root_path)
  end
end
