class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ show edit update destroy]

  def index
    if params[:search].present?
      my_quests = Quest.where(owner: cookies[:name])
      @quests =  my_quests.where("question LIKE ?", "%#{params[:search]}%")
    else
      @quests = Quest.where(owner: cookies[:name])
    end
  end

  def show
  end

  def new
    @quest = Quest.new
    @quest.tasks.build
  end

  def edit
  end

  def create
    @quest = Quest.new(quest_params)
    @quest.owner = cookies[:name]
    respond_to do |format|
      if @quest.save
        format.html { redirect_to quest_url(@quest), notice: "単語作成を成功しました." }
        format.json { render :show, status: :created, location: @quest }
      else
        if @quest.errors[:question].include?("has already been taken")
          @quest.errors.delete(:question)
          @quest.errors.add(:base, "単語は既に存在します.")
        end
        if @quest.errors[:question].include?("can't be blank")
          @quest.errors.delete(:question)
          @quest.errors.add(:base, "単語を入力してください.")
        end
        if @quest.errors[:description].include?("can't be blank")
          @quest.errors.delete(:description)
          @quest.errors.add(:base, "意味を入力してください.")
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @quest.owner != cookies[:name]
      @quest.errors.add(:base, "単語を修正する権限がありません。")
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @quest.errors, status: :unprocessable_entity }
    else
    respond_to do |format|
      if @quest.update(quest_params)
        format.html { redirect_to quest_url(@quest), notice: "単語アップデートを成功しました。" }
        format.json { render :show, status: :ok, location: @quest }
      else
        if @quest.errors[:question].include?("has already been taken")
          @quest.errors.delete(:question)
          @quest.errors.add(:base, "単語は既に存在します.")
        end
        if @quest.errors[:question].include?("can't be blank")
          @quest.errors.delete(:question)
          @quest.errors.add(:base, "単語を入力してください.")
        end
        if @quest.errors[:description].include?("can't be blank")
          @quest.errors.delete(:description)
          @quest.errors.add(:base, "意味を入力してください.")
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
    end
    end

  def destroy
    @quest.destroy

    respond_to do |format|
      format.html { redirect_to quests_url, notice: "単語削除を成功しました。" }
      format.json { head :no_content }
    end
  end

  private
    def set_quest
      @quest = Quest.find_by(id: params[:id])
    end

    def quest_params
      params.require(:quest).permit(:question, :description, tasks_attributes: %i[
      id
      similar_word
      completed
      _destroy
      ])
    end
end
