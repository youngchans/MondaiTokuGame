class RankingController < ApplicationController
  def rank_p
    @top_users = User.order(highest_rate: :desc).limit(10)
  end
end
