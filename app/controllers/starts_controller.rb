class StartsController < ApplicationController
  def start_p
    generate_random_quest
  end

  def submit_answer
    user_selected_option = params[:answer]
    if user_selected_option == 'description'
      increment_correct_answers
    end
    increment_answers
    if session[:answers] == 10
      correct_rate = (session[:correct].to_f / session[:answers] * 100).to_i
      user = User.find(session[:name])
      user.update(highest_rate: correct_rate)
      redirect_to mains_main_path
    else
      generate_random_quest
      redirect_to :starts_start_p
    end
  end


  private

  def initialize_used_ids
    session[:used_id]= []
  end

  def initialize_answers
    session[:answers]= 0
  end

  def increment_answers
    session[:answers] += 1
  end

  def initialize_correct_answers
    session[:correct] = 0
  end

  def increment_correct_answers
    session[:correct]+=1
  end


  def generate_random_quest
    available_ids = Quest.pluck(:id)
    @random_id = available_ids.sample
    if session[:used_id].include?(@random_id)
      @random_id = available_ids.sample
    else
      session[:used_id] << @random_id
    end
    session[:used_id] << @random_id
    @random_quest = Quest.find_by(id: @random_id)
  end
end