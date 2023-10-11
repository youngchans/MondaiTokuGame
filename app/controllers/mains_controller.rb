class MainsController < ApplicationController
  def main
    session[:used_id]= []
    session[:answers]= 0
    session[:correct]= 0
  end
  def destroy
    if current_user.present?
      cookies.delete :name
      cookies.delete :password
      redirect_to logins_login_path
    end
  end
end
