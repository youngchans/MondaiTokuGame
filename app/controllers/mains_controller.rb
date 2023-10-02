class MainsController < ApplicationController
  def main
  end
  def destroy
    if current_user.present?
      cookies.delete :name
      cookies.delete :password
      redirect_to logins_login_path
    end
  end
end
