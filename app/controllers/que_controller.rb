class QueController < ApplicationController
  before_action :que_params, only: [:create]
  def index
    @que = Que.all
  end

  def new
    @que = Que.new
  end

  def create
    @que = Que.new(que_params)

    if @user.save
    redirect_to '/post/index'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  private
  def que_params
    params.require(:que).permit(:question, :description, :wrong_f, :wrong_s)
  end
end
