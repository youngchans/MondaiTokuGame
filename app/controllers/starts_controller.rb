class StartsController < ApplicationController
  def start_p
    task_pre = Task.all
    similar_empty = task_pre.select { |task| task.similar_word.blank? }
    if similar_empty.present?
      redirect_to starts_error_path
    else
      generate_random_quest
    end
    end

  def submit_answer
    user_selected_option = params[:answer]
    if user_selected_option == 'description'
      increment_correct_answers
    end
    increment_answers
    if session[:answers] == 10
      @correct_rate = (session[:correct].to_f / session[:answers] * 100).to_i
      user = User.find(cookies[:name])
      user.update(highest_rate: @correct_rate)
      flash[:success] = "お疲れ様でした！#{session[:answers]}中#{session[:correct]}正解で正解率は#{(session[:correct].to_f / session[:answers] * 100).to_i}％です！"
      redirect_to ranking_rank_p_path
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
    @quest_similar = Task.find_by(quest_id: @random_id)
    similar_id = Task.pluck(:quest_id)
    unique_available_ids = similar_id.to_a.difference([@random_id].flatten)
    @rand_similar_id = unique_available_ids.sample
    @random_similar = Task.find_by(quest_id: @rand_similar_id)
  end
end