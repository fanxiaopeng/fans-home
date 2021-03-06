# -*- encoding : utf-8 -*-
# ApplicationController
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_i18n_session
  before_action :set_default_login, except: [:login, :logout, :create]
  helper_method :current_user, :current_is_admin_role

  private

  def set_i18n_session
    unless session[:default_locale]
      accept_language = get_default_locale(request.env['HTTP_ACCEPT_LANGUAGE'])
      set_locale(accept_language)
    end
  end

  def get_default_locale(language_request)
    language = language_request.scan(/^[a-z]{2}/).first
    if language.downcase == 'zh'
      language = 'zh'
    else
      language = 'en'
    end
    language
  end

  def set_locale(locale)
    I18n.locale = session[:default_locale] = locale
  end

  def set_session_cookie(user, remember_me)
    session[:user] = user.id
    cookies[:user] = { value: user.id, expires: 1.week.from_now } if remember_me == 'yes'
  end

  def set_default_login
    session[:user] = cookies[:user] if cookies[:user].present?
  end

  def set_logout
    session[:user] = cookies[:user] = nil
  end

  def current_is_admin_role
    user = User.find(session[:user]) if session[:user]
    is_admin_user = false
    is_admin_user = user.role == 'admin' if user.present?
    is_admin_user
  end

  def current_user
    @c_user || @c_user = User.find_by(id: session[:user])
  end

  def current_user?(user)
    session[:user] == user.id.to_s
  end

  def user_admin_check
    redirect_to root_url unless current_is_admin_role
  end
end
