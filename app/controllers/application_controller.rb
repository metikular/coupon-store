class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :switch_locale

  helper_method :page_classes
  helper_method :body_classes

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def page_classes
    ""
  end

  def body_classes
    "p-6"
  end
end
