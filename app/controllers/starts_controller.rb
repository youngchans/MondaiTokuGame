class StartsController < ApplicationController
  def start_p
    
    session[:current_category] = params[:category] if params[:category]
    @category = session[:current_category]
    task_pre = Task.all
    similar_empty = task_pre.select { |task| task.similar_word.blank? }
    if similar_empty.present? || Quest.count <= 10
      redirect_to starts_error_path
    else
      unless session[:question_generated]
        make_question
        session[:question_generated] = true
      end
      generate_random_quest
      respond_to do |format|
        format.html
        format.json do
          render json: {
            category: @category,
            question: @random_quest.question,
            options: [
              { value: "description", label: @random_quest.description },
              { value: "wrong_description", label: @random_wrong.description},
              { value: "wrong_description2", label: @random_wrong2.description }
            ]
          }
        end
      end
    end
    end

  def submit_answer
    user_selected_option = params[:answer]
    if user_selected_option == 'description'
      increment_correct_answers
    end
    increment_answers

    if session[:answers] >= 10
      session[:question_generated] = false
      @correct_rate = (session[:correct].to_f / session[:answers] * 100).to_i
      user = User.find(cookies[:name])
      if @correct_rate>user.highest_rate
      user.update(highest_rate: @correct_rate)
      end
      flash[:success] = "お疲れ様でした！#{session[:answers]}中#{session[:correct]}正解で正解率は#{(session[:correct].to_f / session[:answers] * 100).to_i}％です！"
      redirect_to ranking_rank_p_path
    else
      generate_random_quest
      redirect_to:starts_start_p
    end
  end


  private

  def make_question
  if @category == "生物"
    category_tag = Tag.find_by(tag: "生物")
  else
    category_tag = Tag.find_by(tag: "無生物")
  end

  tagged_quest_tags = QuestTag.where(tag_id: category_tag.id)
  tagged_quest_ids = tagged_quest_tags.pluck(:quest_id)
  
  @questions = []
  10.times do
    question_id = tagged_quest_ids.sample
    while @questions.include?(question_id)
      question_id = tagged_quest_ids.sample
    end
    @questions << question_id
  end
  
  session[:questions] = @questions
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
  def render_json_response
    render json: {
      category: @category,
      question: @random_quest.question,
      options: [
        { value: "description", label: @random_quest.description },
        { value: "wrong_description", label: @random_wrong.description },
        { value: "wrong_description2", label: @random_wrong2.description }
      ]
    }
  end


  def generate_random_quest
    index = session[:answers] 
    @random_id = session[:questions][index]
    @random_quest = Quest.find_by(id: @random_id)
    @quest_similar = Task.where(quest_id: @random_id)
    similar_id = Task.pluck(:quest_id)
    unique_available_ids = similar_id.to_a.difference([@random_id].flatten)
    @rand_similar_id = unique_available_ids.sample
    @random_wrong = Quest.where.not(id: @random_id).order("RANDOM()").first
    @random_wrong2 = Quest.where.not(id: [@random_id, @random_wrong.id]).order("RANDOM()").first
  end
end