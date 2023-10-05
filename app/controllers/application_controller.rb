class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    @current_user ||= User.find_by(name: cookies[:name], password_digest: cookies[:password])
  end
end
