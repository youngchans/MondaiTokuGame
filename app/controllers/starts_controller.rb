class StartsController < ApplicationController
  def start_p
    session[:current_category] = params[:category] if params[:category]
    @category = session[:current_category]
    task_pre = Task.all
    similar_empty = task_pre.select { |task| task.similar_word.blank? }
    if similar_empty.present? || Quest.count <= 10
      redirect_to starts_error_path
    else
      generate_random_quest
      respond_to do |format|
        format.html
        format.json do
          render json: {
            category: @category,
            question: @random_quest.question,
            options: [
              { value: "description", label: @random_quest.description },
              { value: "similar_word", label: @quest_similar.similar_word },
              { value: "similar_word2", label: @random_similar.similar_word }
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
      @correct_rate = (session[:correct].to_f / session[:answers] * 100).to_i
      user = User.find(cookies[:name])
      if @correct_rate>user.highest_rate
      user.update(highest_rate: @correct_rate)
      end
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
  def render_json_response
    render json: {
      category: @category,
      question: @random_quest.question,
      options: [
        { value: "description", label: @random_quest.description },
        { value: "similar_word", label: @quest_similar.similar_word },
        { value: "similar_word2", label: @random_similar.similar_word }
      ]
    }
  end


  def generate_random_quest
    if @category == "生物"
      category_tag = Tag.find_by(tag: "生物")
      tagged_quest_tags = QuestTag.where(tag_id: category_tag.id)
      tagged_quest_ids = tagged_quest_tags.pluck(:quest_id)
      available_ids = Quest.where(id: tagged_quest_ids)
    else
      category_tag = Tag.find_by(tag: "無生物")
      tagged_quest_tags = QuestTag.where(tag_id: category_tag.id)
      tagged_quest_ids = tagged_quest_tags.pluck(:quest_id)
      available_ids = Quest.where(id: tagged_quest_ids)
    end
    
    @random_id = available_ids.sample
    @random_quest = Quest.find_by(id: @random_id)
    @quest_similar = Task.find_by(quest_id: @random_id)
    similar_id = Task.pluck(:quest_id)
    unique_available_ids = similar_id.to_a.difference([@random_id].flatten)
    @rand_similar_id = unique_available_ids.sample
    @random_similar = Task.find_by(quest_id: @rand_similar_id)

    
  end
end