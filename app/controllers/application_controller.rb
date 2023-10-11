class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    @current_user ||= User.find_by(name: session[:name], password_digest: session[:password])
  end
end
