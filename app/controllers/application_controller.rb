class ApplicationController < ActionController::Base
  before_filter :authenticate

  protect_from_forgery

  helper_method :current_user

  def authenticate
    unless session[:user_id]
      session[:return_url] ||= request.url
      redirect_to polymorphic_url(:new_user_session) and return
    end
    unless Rails.application.config.authorized_users.include?(current_user)
      unauthorized
    end
  end

  def current_user
    session[:user_id]
  end

  def unauthorized
    raise ActionController::RoutingError.new 'Unauthorized'
  end
end
