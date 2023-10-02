class LoginsController < ApplicationController
  def new
  end

  def create
    if params[:name].present? && params[:password].present?
      user = User.find_by(name: params[:name])
      if user.present? && user.authenticate(params[:password])
        flash[:notice] = "ログイン成功しました。"
        cookies[:name] = user.name
        cookies[:password] = user.password_digest
        redirect_to '/mains/main'
      else
        flash[:notice] = "間違っているIDかパスワードです。もう一度確認してください。"
        redirect_to logins_login_path
      end
    else
      flash[:notice] = "IDとパスワードを入力してください。"
      redirect_to logins_login_path
    end
    end
  end