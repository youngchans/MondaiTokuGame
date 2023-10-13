class UsersController < ApplicationController
  before_action :user_params, only: [:create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "ユーザー作成を成功しました。"
        redirect_to root_path
    else
      flash[:fail] = "ユーザー作成を失敗しました。（既にユーザ名が存在しております。パスワードが違います。）"
      render :new
    end
  end
  private
  def user_params
    params.require(:user).permit( :name, :password, :password_confirmation, :birth_date)
  end
end