class SearchesController < ApplicationController
  def result
    @searches = eval(params[:bulletin]).where("question like ?", "%#{params[:search_text]}%")
  end
end
