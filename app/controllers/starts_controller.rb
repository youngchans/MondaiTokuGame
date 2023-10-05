class StartsController < ApplicationController
  before_action :initialize_used_ids
  before_action :initialize_answers
  before_action :initialize_correct_answers

  def start_p
    generate_random_quest
    respond_to do |format|
      format.html
      format.json { render json: { random_quest: @random_quest, answers: @answers } }
    end
  end

  def submit_answer
    user_selected_option = params[:selected_option]

    if user_selected_option == "description"
      increment_correct_answers
    end

    increment_answers

    if @answers == 9
      correct_rate = (@correct_answers.to_f / @answers * 100).to_i
      user = User.find(current_user.id)
      user.update(highest_rate: correct_rate)
      render json: { finished: true, correctRate: correct_rate }
    else
      generate_random_quest
      render json: { random_quest: @random_quest, answers: @answers }
    end
  end

  private

  def initialize_used_ids
    @used_ids ||= []
  end

  def initialize_answers
    @answers = 0
  end

  def increment_answers
    @answers += 1
  end

  def initialize_correct_answers
    @correct_answers = 0
  end

  def increment_correct_answers
    @correct_answers += 1
  end

  def generate_random_quest
    available_ids = Quest.pluck(:id) - @used_ids

    if available_ids.empty?
      @used_ids = []
      available_ids = Quest.pluck(:id) - @used_ids
    end

    random_id = available_ids.sample
    @random_quest = Quest.find_by(id: random_id)

    @used_ids << random_id
  end
end