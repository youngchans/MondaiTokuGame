class MainsController < ApplicationController
  def main
    session[:used_id]= []
    session[:answers]= 0
    session[:correct]= 0
  end
  def destroy
    if cookies[:name].present? && cookies[:password].present?
      cookies.delete :name
      cookies.delete :password
      redirect_to logins_login_path
    end
  end
  def change_p
    @user= User.find(cookies[:name])
  end
  def update
    @user = User.find(cookies[:name])
    @user.password = params[:password]
    if params[:password] == params[:password_confirmation]
      @user.save
      flash[:change_success] = "パスワード変更を成功しました。"
      cookies.delete :name
      cookies.delete :password
      redirect_to root_path
    else
      flash[:fail] = "パスワード変更を失敗しました。（パスワードが違います）"
      redirect_to mains_change_p_path
    end
  end

end
