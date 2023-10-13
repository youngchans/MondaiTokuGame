class FindsController < ApplicationController
  def new
  end
    def search
        user= User.find_by(name: params[:name])
      if user.present?
        cookies[:name] =user.id
        redirect_to '/finds/check'
      else
        flash[:fail] = "存在していないIDです。"
        redirect_to '/finds/find'
      end
    end
    def validate
      user_birth_date = User.find(cookies[:name]).birth_date
      input_birth_date = Date.parse(params[:birth_date])

      # birth_date 비교
      if user_birth_date == input_birth_date
        redirect_to mains_change_p_path
      else
        flash[:fail] = "生年月日が登録情報と違います。"
        redirect_to '/finds/check'
      end
    end
  end
